#!/bin/sh
#
# Show an OSX alert 
#
# This is useful when used in conjunction with a long-running script. Use this script to 
# get a notification when te long-running script finishes.
# 
# Eg:
#
#   $ ./someprocess ; boo
#   $ ./someprocess ; boo "npm install has finished! HOORAY!"

TITLE="🚀"
MESSAGE="${1:-"Good news master. Your script has finished running"}"
ICON="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ErasingIcon.icns"

terminal-notifier -title "$TITLE" -message "$MESSAGE" 
