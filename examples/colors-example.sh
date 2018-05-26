#!/bin/bash

source vendor/sources.sh

require_lib colors

echo "Normal text."
red
echo "This text is in red."
uncolor 
echo "This is normal again."

echo "This line has a $(green)GREEN$(uncolor) word in it."

echo "$(bred;yellow;bold)Attention! You won't miss this probably! $(uncolor)"
 
echo "But even $(bblue;cyan;bold)THAT$(uncolor) can be done for a single word."
