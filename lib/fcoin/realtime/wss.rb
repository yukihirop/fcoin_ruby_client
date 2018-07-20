require 'faye/websocket'
require 'eventmachine'
require_relative 'formatter'

# Scope Fcoin::RealTime::API
module Fcoin
  module RealTime
    module WSS
      def on(topic, limit=nil, &block)
        self.topics << { topic: topic, limit: limit }
        self.callbacks[topic] ||= []
        self.callbacks[topic] << block if block_given?
      end

      def subscribe
        EM.run do
          wss = Faye::WebSocket::Client.new(wss_endpoint)

          wss.on(:open) do |handshake|
            self.topics.each do |args|
              wss.send(valid_payload(args))
            end
          end

          wss.on(:message) do |event|
            data       = JSON.parse(event.data)
            event_name = data["type"]
            formatter  = Fcoin::RealTime::Formatter.build(data)
            call_callbacks(event_name, formatter.formatted_data)
          end

          wss.on(:close) do |event|
            call_callbacks(:close)
            EM.stop
          end

          wss.on(:error) do |event|
            call_callbacks(:error)
            EM.stop
          end

          # hit Control + C to stop
          Signal.trap("INT")  { EM.stop }
          Signal.trap("TERM") { EM.stop }
        end
      end

      private

      def on?(event_name)
        event_name.present? && callbacks[event_name].present?
      end

      def call_callbacks(event_name, data={})
        return unless on?(event_name)
        callbacks[event_name].each do |callback|
          callback.call data
        end
      end

      def valid_payload(args)
        topic = args[:topic]
        limit = args[:limit]
        payload = if limit.present?
                    { cmd: :sub, args: [topic, limit] }
                  else
                    { cmd: :sub, args: [topic] }
                  end
        JSON.dump(payload)
      end
    end
  end
end