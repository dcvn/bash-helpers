#!/bin/bash

source vendor/sources.sh

require_lib syslog

APPNAME=my-wonderfull-script


# First round.

openlog $APPNAME pid local1

syslog info "Running ${BASH_SOURCE[0]}"

# See: printf style!
BGNAME=Holiday
NUMIMG=6
syslog info "Background '%s' shall have %d images." $BGNAME $NUMIMG

closelog

echo "-- Look in /var/log/syslog to see the written logs. --"

# Next round.
 
openlog  $APPNAME pid local3

syslog warning "%d connections from %s" 54 "spam.mer.in"

syslog authpriv.err "intruder alert!"

closelog

echo "-- Look in /var/log/auth.log for the authpriv.err message. --"
