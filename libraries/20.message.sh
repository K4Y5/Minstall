#!/bin/bash
# Headers & Messages

# Print Header
header() {
	echo -e "\e[1;34m>> \e[1;37m$* \e[1;34m<<\e[0m"
}

# Print Subheader
subheader() {
	echo -e "\e[1;32m>> \e[1;37m$*\e[0m"
}

# Print Error Message
error() {
	echo -e "\e[1;31m$*\e[0m"
}

# Print Warning Message
warning() {
	echo -e "\e[1;33m$*\e[0m"
}
