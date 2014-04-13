#!/bin/bash
# Manage: User Manage

# Manage User
manage-user

# Module Function
module() {
	# Check User
	manage-user-check-user $USER

	# Check Variable Set State
	if [[ -z "$PASS" ]]; then
		# Set Password
		manage-user-set-password $USER
	else
		# Set Password
		manage-user-set-password $USER $PASS
	fi

	# Clean Cron Entry
	manage-user-clean-cron $USER

	# Check Package
	if check_package "nginx"; then
		# User HTTP Directory Question
		if question --default yes "Do you want to add a HTTP directory for this user? (Y/n)" || [ $HTTP = 1 ]; then
			manage-user-http-directory $USER
		fi
	fi

	# User Set Permissions Question
	if question --default yes "Do you want to set permissions for this user to enable enhanced privacy? (Y/n)" || [ $PERM = 1 ]; then
		manage-user-set-permissions $USER
	fi
}

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check
	manage-user-input-check

	# Module Function
	module
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_variable_module user),
	PASSLIST=$(read_variable_module pass),
	HTTPLIST=$(read_variable_module http),
	PERMLIST=$(read_variable_module perm),

	# Loop Through Users
	while echo $USERLIST | grep -q \,; do
		# Define Variables
		USER=${USERLIST%%\,*}
		PASS=${PASSLIST%%\,*}
		HTTP=${HTTPLIST%%\,*}
		PERM=${PERMLIST%%\,*}

		# Remove Current From List
		USERLIST=${USERLIST#*\,}
		PASSLIST=${PASSLIST#*\,}
		HTTPLIST=${HTTPLIST#*\,}
		PERMLIST=${PERMLIST#*\,}

		# Check User Array State
		manage-user-check-array $USERLIST

		# Module Function
		module
	done

	# Unset Arrays
	unset USERLIST
	unset PASSLIST
	unset HTTPLIST
	unset PERMLIST

	# Unset Variables
	unset USER
	unset PASS
	unset HTTP
	unset PERM
fi

# Unset Init
unset -f init
