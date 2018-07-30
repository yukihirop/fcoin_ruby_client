require 'faye/websocket'
require 'eventmachine'
require_relative 'formatter'

# Scope Fcoin::RealTime::API
module Fcoin
  module RealTime
    module WSS
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
            topic = data["type"]
            formatter  = Fcoin::RealTime::Formatter.build(data)
            call_callbacks(topic, formatter.formatted_data)
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

      def on(topic, limit=nil, &block)
        self.topics << { topic: topic, limit: limit }
        self.callbacks[topic] ||= []
        self.callbacks[topic] << block if block_given?
      end

      def on?(topic)
        topic.present? && callbacks[topic].present?
      end

      def call_callbacks(topic, data={})
        return unless on?(topic)
        callbacks[topic].each do |callback|
          callback.call data
        end
      end

      def valid_payload(args)
        topic = args[:topic]
        limit = args[:limit]
        payload = if limit.present?
                    { cmd: :sub, args: [topic, limit], id: SecureRandom.uuid }
                  else
                    { cmd: :sub, args: [topic], id: SecureRandom.uuid }
                  end
        JSON.dump(payload)
      end
    end
  end
end