#!/bin/bash

source vendor/sources.sh

require_lib find

echo "-- This is probably a long list --"
find_mime_files image "/usr/share/images"

echo "-- This should have no results: --"
find_mime_files video "/usr/share/images"

echo "-- Back to the images, now in a random order: --"
find_mime_files image "/usr/share/images" | sort_random

echo "-- If we had to randomize more than 1000 results... --"
find_mime_files image "/usr/share/images" | sort_random 5000

echo "-- ... and pick only 10 of them...  --"
find_mime_files image "/usr/share/images" | sort_random 5000 | head -n 10
