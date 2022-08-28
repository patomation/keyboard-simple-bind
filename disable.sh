#!/bin/bash
# Get config variables
source config.sh
# Disable the keyboard by id
xinput float "$keyboard_id"