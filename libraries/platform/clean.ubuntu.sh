#!/bin/bash
# Functions For Cleaning Packages/Files (Ubuntu 12.04)

# Clean Files
function clean_files() {
	# Remove Files Not Removed By APT
	rm -rf $(grep "not empty so not removed" temp.log | sed "s/[^']*'//;s/'[^']*$//")
}

# Clean Packages
function clean_packages() {
	# Clear DPKG Package Selections
	dpkg --clear-selections

	# Set Package Selections
	dpkg --set-selections < temp.dpkg

	# Get Selections & Set To Purge
	dpkg --get-selections | sed -e "s/deinstall/purge/" > temp.dpkg

	# Set Package Selections
	dpkg --set-selections < temp.dpkg

	# Update DPKG
	DEBIAN_FRONTEND=noninteractive apt-get -qy dselect-upgrade 2>&1 | tee -a temp.log

	# Clean Package List
	package_clean_list
}
