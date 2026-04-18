#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[1m\033[0;34m'
NC='\033[0m' # No Color

# Directory and Log setup
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
LOG_FILE="$BASE_DIR/scripts/installer/hyprland-uwsm.log"
SUDOERS_TEMP="/etc/sudoers.d/hyprland-installer-temp"

# Cleanup function if the script is interrupted
function trap_message {
    print_error "\n\nScript interrupted. Exiting.....\n"
    # Remove temporary sudo privileges on exit/interrupt
    [[ -f "$SUDOERS_TEMP" ]] && rm -f "$SUDOERS_TEMP"
    log_message "Script interrupted and temporary privileges revoked"
    exit 1
}

# Logger function
function log_message {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Formatted output functions
function print_error { echo -e "${RED}$1${NC}"; }
function print_success { echo -e "${GREEN}$1${NC}"; }
function print_warning { echo -e "${YELLOW}$1${NC}"; }
function print_info { echo -e "${BLUE}$1${NC}"; }
function print_bold_blue { echo -e "${BLUE}$1${NC}"; }

# Placeholder for confirmation (auto-confirms in this setup)
function ask_confirmation {
    print_warning "$1 (y/n): "
    log_message "Auto-confirmed: $1"
    return 0 
}

# Main command runner
function run_command {
    local cmd="$1"
    local description="$2"
    local use_sudo="${4:-yes}"

    local full_cmd=""
    if [[ "$use_sudo" == "no" ]]; then
        full_cmd="sudo -u $SUDO_USER $cmd"
    else
        full_cmd="$cmd"
    fi

    log_message "Attempting: $description"
    print_info "\n$description"
    
    while ! eval "$full_cmd"; do
        print_error "Command failed: $cmd"
        log_message "Error running: $cmd"
        return 1
    done
    return 0
}

# Script execution wrapper
function run_script {
    local script="$BASE_DIR/scripts/installer/$1"
    print_info "\nExecuting '$2' script..."
    while ! bash "$script"; do
        print_error "$2 failed. Retrying..."
        log_message "$2 failed, retrying."
    done
    log_message "$2 completed successfully."
}

# Root check and user identification
function check_root {
    if [ "$EUID" -ne 0 ]; then
        print_error "Please run as root (sudo ./install.sh)"
        exit 1
    fi
    SUDO_USER=$(logname)
    log_message "Running as root for user: $SUDO_USER"
}

# OS verification
function check_os {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" != "arch" ]]; then
            print_warning "Non-Arch OS detected ($PRETTY_NAME). Proceeding anyway."
        fi
    fi
}
