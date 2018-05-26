#!/bin/bash

source vendor/sources.sh

require_lib printlog

APPNAME=my-wonderfull-script
VERBOSE=0
QUIET=0

# Will print:
print_log Hello people!

# Will not print:
print_verbose Hello verbose people!

VERBOSE=1
# Now it will:
print_verbose Hello verbose people again!

# Will print:
print_noquiet Hello not-so-quiet ehm... who are you?

QUIET=1
# Not anymore now.
print_noquiet Helloho! Way too quiet here!

# Because the script has an appname:
print_app_log The script is busy....

# We are still verbose...
print_app_verbose The script does many small things to talk about.

VERBOSE=0
# Not anymore.
print_app_verbose The script does so many very small things, so funny!
