module Lita
  module Handlers
    class Twilio < Handler

      require 'twilio-ruby'

      config :default_room, type: String, required: true
      config :account_sid, type: String, required: true
      config :auth_token, type: String, required: true
      config :phone_number, type: String, required: true
      config :server_token, type: String, required: true

      http.post '/twilio', :receive_sms

      route %r{^sms ([0-9]{3}-[0-9]{3}-[0-9]{4}) (.*)}i, :send_sms, help: {
        "litabot: sms 415-867-5309 message content" => "Sends the SMS message to the number inputted"
      }

      def target
        @target ||= config.default_room
      end

      def receive_sms(request, response)
        return unless request.params.delete('token') == config.server_token
        if request && request.params && !request.params.empty?
          decoded = MultiJson.load(request.params.keys.first)
          robot.send_message(target, "Message from #{decoded['From']}: #{decoded['Body']}")
        end
      end

      def send_sms(response)
        begin
          client = ::Twilio::REST::Client.new(config.account_sid, config.auth_token)

          if client.account.messages.create(:from => config.phone_number,
                                            :to => response.matches[0][0],
                                            :body => response.matches[0][1])
            robot.send_message(target, "Sent message to #{response.matches[0][0]}")
          end
        rescue Exception => e
          robot.send_message(@target, "Failed to send message: #{e.message}")
        end

      end

    end
    Lita.register_handler(Twilio)
  end
end
