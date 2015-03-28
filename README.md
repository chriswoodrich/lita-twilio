# lita-twilio

Lita-Twilio integrates your Twilio account into Lita. Send and receive text messages from your company chat room.

## Installation

Add lita-twilio to your Lita instance's Gemfile:

``` gem "lita-twilio" ```

## Configuration

There's a bit of Yak-shaving to do here, sorry.

It's best to create your own ```test_credentials.yml```, save it to 'spec/lita/handlers/', and populate these fields:
 ```
default_room: "replace_me"
account_sid: "replace_me"
auth_token: "replace_me"
phone_number: "replace_me"
test_recipient_phone_number: "replace_me"
```
and then to ```bundle``` and run the specs (100% coverage).  VCR is used in the SMS testing so you will only ever need to make one successful request to Twilio.

### Optional attributes
* **default_room** (`String`) - The room or person Lita will message on receipt of incoming SMS. Default: `#team`.

### Required attributes
* **account_sid** (`String`) Your Twilio account's sid.
* **auth_token** (`String`) Your Twilio account's auth_token.
* **phone_number** (`String`) Your Twilio account's phone_number.

### Twilio Account Setup
* If you have the free account, you'll need to manually add and verify numbers to which you want to send.
* Go to ```https://www.twilio.com/user/account/phone-numbers/incoming``` and change the ```Request URL``` to ```http://yourdomain.com/lita/text```

## Usage

*```Litabot: send_sms 415-867-5309 Hello Jenny``` will send an SMS to (415) 867-5309 with the message "Hello Jenny"
* Phone numbers must be strictly in the XXX-XXX-XXXX format, and send_sms must be used as a command to Litabot.
* Any incoming messages to your Twilio account will be displayed with the message and sender.

## License

[MIT](http://opensource.org/licenses/MIT)
