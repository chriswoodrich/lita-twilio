require "spec_helper"
require 'vcr'

describe Lita::Handlers::Twilio, lita_handler: true do
  it { is_expected.to route_http(:post, "/twilio?token=#{ENV['SERVER_TOKEN']}").to(:receive_sms) }
  it { is_expected.to route_command("sms 415-867-5309 JENNNNNNY").to(:send_sms) }


  before do
    registry.config.handlers.twilio.default_room = ENV["DEFAULT_ROOM"]
    registry.config.handlers.twilio.account_sid = ENV["ACCOUNT_SID"]
    registry.config.handlers.twilio.auth_token = ENV["AUTH_TOKEN"]
    registry.config.handlers.twilio.phone_number = ENV["PHONE_NUMBER"]
    registry.config.handlers.twilio.server_token = ENV["SERVER_TOKEN"]
    registry.config.http.host = '127.0.0.1'
    registry.config.http.port = '8080'
  end

  describe '#receive' do
    let(:request) do
      request = double('Rack::Request')
      allow(request).to receive(:params).and_return(params)
      request
    end
    let(:params) { {'Body' => 'Hi Lita!', 'From' => 'Jimmy'} }
    let(:response) { Rack::Response.new }
    it 'sends alerts user to the received message' do
      response = http.post("/twilio?token=#{ENV['SERVER_TOKEN']}", params.to_json)
      expect(replies.last).to include('Hi Lita!')
    end
  end

  describe '#send_sms' do
    it "Outputs a message that a message was sent, given proper params" do
      VCR.use_cassette('sms') do
        t = ENV["TEST_RECIPIENT_PHONE_NUMBER"]
        response = send_command("sms #{t} this is a test message")
        expect(replies.last).to eq "Sent message to #{t}"
      end
    end
    it "Fails gracefully if Twilio generates an exception" do
      send_command("sms 000-000-0000 OK computer")
      expect(replies.last).to include('Failed to send message:')
    end
  end

  describe "Twilio is pointing the Lita's webserver address and triggers received message callback" do
    it 'should point to Lita\'s post route and trigger a robot message' do
      full = "http://#{Lita.config.http.host}:#{Lita.config.http.port}/twilio?token=#{ENV['SERVER_TOKEN']}"
      response = http.post(full, {'Body' => 'Hi Jimmy!', 'From' => 'Lita'}.to_json )
      expect(response.status).to eq 200
      expect(replies.last).to include('Hi Jimmy!')
    end
  end

end

