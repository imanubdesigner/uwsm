#!/bin/bash

LOG="$HOME/.local/share/manu/first-run.log"

echo "$(date): Restoring sudoers to cpupower + tlp only..." >> "$LOG"

# Overwrite the sudoers file to leave only permanent permissions.
# We use /usr/bin/tee because it was authorized in theming.sh.
echo 'manu ALL=(ALL) NOPASSWD: /usr/bin/cpupower, /usr/bin/tlp' | sudo /usr/bin/tee /etc/sudoers.d/manu-powerprofile > /dev/null 2>> "$LOG"

# Check if the previous command succeeded
if [ $? -eq 0 ]; then
    echo "$(date): Sudoers restored successfully." >> "$LOG"
else
    echo "$(date): ERROR: Failed to restore sudoers." >> "$LOG"
fi
