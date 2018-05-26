#!/bin/bash 

source vendor/sources.sh

require_lib mail

# Replace these with your own.
MAILSERVER_FQDN="mail.your-isp.invalid"
MAIL_DEFAULT_TO="your-name@your-isp.invalid"
MAIL_DEFAULT_TO_NAME="Your Name"
MAIL_DEFAULT_FROM="your-site@your-isp.invalid"
MAIL_DEFAULT_FROM_NAME="Your Site"

MAILBODY_PLAIN="What a nice image this is.
You really should see it."


# Compose message, dump to stdout.
mail_mime_image_inline "image.jpg" "Image of the day" 

# The same, but now really send it!
mail_mime_image_inline "image.jpg" "Image of the day" | mail_send_tcp 

# It depends on your mail server configuration, as well as spam filters,
# whether your mail will arrive. Try it, test it.


# As above, but not inline.
# Compose message, dump to stdout.
mail_mime_image_attach "image.jpg" "Image of the day (attachment)" 
# 
mail_mime_image_attach "image.jpg" "Image of the day (attachment)" | mail_send_tcp
