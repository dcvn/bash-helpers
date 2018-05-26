#!/bin/bash

source vendor/sources.sh

require_lib network

require_commands wget

echo "-- This is your external IP address: --"
my_ext_ip

