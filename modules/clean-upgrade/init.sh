#!/bin/bash
# Clean: Upgrade System

# Update Package Lists
subheader "Updating Package Lists..."
package_update

# Upgrade Packages
subheader "Upgrading Packages..."
package_upgrade

# Clean Package Cache
subheader "Cleaning Package Cache..."
package_clean

# Common Clean
common-clean
