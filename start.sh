#!/bin/bash

# Get config variables
source config.sh

# SOURCE : https://unix.stackexchange.com/questions/35649/second-keyboard-to-run-commands
# 15 is the id of the floating (ie disabled) usb keyboard
#    xinput --float 15

xinput --test "$keyboard_name" \
  | grep --line-buffered "key press" | while read -r line; do
  # echo "$line"
  # remove "key press" and keey just the number: 
  # https://stackoverflow.com/questions/16623835/remove-a-fixed-prefix-suffix-from-a-string-in-bash
  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
  keycode="${line#"key press   "}" 
  echo "$keycode"
  # Get string after keycode in that one line with sed
  COM=$(sed -n -e 's/^.*\(\( '"$keycode"' \)\)//p' mapping)
  echo "$COM"
  # execute the command
  $COM
done