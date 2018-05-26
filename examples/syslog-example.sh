#!/bin/bash

source vendor/sources.sh

require_lib syslog

APPNAME=my-wonderfull-script


# Open for pid.local1
openlog $APPNAME pid local1

syslog info "Running ${BASH_SOURCE[0]}"

BGNAME=Holiday
NUMIMG=6

syslog info "Background '%s' shall have %d images." $BGNAME $NUMIMG

closelog

echo "-- Look in /var/log/syslog to see the written logs. --"
 