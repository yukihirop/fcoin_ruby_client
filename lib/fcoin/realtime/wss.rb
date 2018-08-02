require 'faye/websocket'
require 'eventmachine'
require_relative 'formatter'

# Scope Fcoin::RealTime::API
module Fcoin
  module RealTime
    module WSS
      # Subscribe to the channel that you have added to the topics
      #
      # @note Please subscribe to the channel by calling client.on_hello(&block) for the first time
      #
      # @example Subscribe to Subscribe to server time
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_hello do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"type"=>"hello", "ts"=>1532953247264}
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
            formatter  = Fcoin::RealTime::Formatter.new(data)
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
      # Subscribe to topic
      #
      # @param topic [String or Symbol] Channel you want to subscribe to
      # @param limit [Integer]
      def on(topic, limit=nil, &block)
        self.topics << { topic: topic, limit: limit }
        self.callbacks[topic] ||= []
        self.callbacks[topic] << block if block_given?
      end

      # Subscribe topic?
      #
      # @param topic [String] Channel you want to subscribe to
      def on?(topic)
        topic.present? && callbacks[topic].present?
      end

      # call callbacks
      #
      # @param topic [String] Channel you want to subscribe to
      # @param data [Hash] Data sent from subscribed channel
      def call_callbacks(topic, data={})
        return unless on?(topic)
        callbacks[topic].each do |callback|
          callback.call formatted(data)
        end
      end

      # change the output format of the body
      #
      # @param data [Hash]
      # @return [Hash or JSON]
      def formatted(data)
        case format_type
        when :json
          data.to_json
        when :hash
          data
        else
          raise "format_type is #{format_type}. format_type must be included in [:json, :hash]."
        end
      end

      # Prepare a valid payload
      #
      # @param args [Hash] Parameters to send to subscribed channel
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