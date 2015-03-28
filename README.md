[![Build Status](https://travis-ci.org/chriswoodrich/lita-twilio.svg?branch=master)](https://travis-ci.org/chriswoodrich/lita-twilio)

# lita-twilio

Lita-Twilio integrates your Twilio account into Lita. Send and receive text messages from your company chat room.

## Installation

Add lita-twilio to your Lita instance's Gemfile:

``` gem "lita-twilio" ```

## Configuration

There's a bit of Yak-shaving to do here, sorry.

### Required attributes
* **default_room** (`String`) - The room or person Lita will message on receipt of incoming SMS.
* **account_sid** (`String`) Your Twilio account's sid.
* **auth_token** (`String`) Your Twilio account's auth_token.
* **phone_number** (`String`) Your Twilio account's phone_number.
* **server_token** (`String`) A keyphrase you will use to authenticate requests to the :post route.  You'll need this token to properly setup Twilio callbacks to power the receive route.

### Twilio Account Setup
* If you have the free account, you'll need to manually add and verify numbers to which you want to send.
* Go to ```https://www.twilio.com/user/account/phone-numbers/incoming``` and change the ```Request URL``` under messages to ```http://yourdomain.com/twilio?token=VALUE-OF-YOUR-CONFIG-SERVER_TOKEN```.

## Usage

*```Litabot: sms 415-867-5309 Hello Jenny``` will send an SMS to (415) 867-5309 with the message "Hello Jenny"
* Phone numbers must be strictly in the XXX-XXX-XXXX format, and sms or SMS (case insensitive) must be used as a command to Litabot.
* Any incoming messages to your Twilio account will be displayed with the message and sender.

## License

[MIT](http://opensource.org/licenses/MIT)
