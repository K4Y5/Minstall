#!/bin/bash
# Basic Adminer Installer

###############
## Variables ##
###############

# User (Owner Of Virtual Host)
USER="main"

# Virtual Host
HOST="host.example.com"

# Directory Under Virtual Host In Which Script Will Be Installed, Leave Empty For Installation Into Virtual Host Root
DIRECTORY="adminer"

# Script File Name
NAME="index.php"

# Script URL
URL="http://www.sourceforge.net/projects/adminer/files/Adminer/Adminer%203.7.1/editor-3.7.1.php/download"

# Theme URL, Leave Empty For Default
THEME="http://raw.github.com/vrana/adminer/master/designs/pokorny/adminer.css"

############
## Script ##
############

# Change Directory
cd /home/$USER/http/hosts/$HOST

# Check If Directory Variable Empty
if [[ $DIRECTORY != "" ]]; then
	# Make Script Directory
	mkdir $DIRECTORY

	# Change Directory
	cd $DIRECTORY
fi

# Download Script
wget -O $NAME "$URL"

# Check If Theme Variable Empty
if [[ $THEME != "" ]]; then
	# Download Theme
	wget -O adminer.css "$THEME"
fi

# Update Owner
chown -R $USER:$USER .

# Update Permissions
chmod -R o= .
