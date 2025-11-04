#!/bin/bash

# ============================================================
#  Helper Functions for Hyprland-UWSM Installer
#  Includes AUTO_MODE (skip confirmations) and failure summary
# ============================================================

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Auto mode (set to "true" to skip all confirmations)
AUTO_MODE="true"

# Keep track of failed commands
FAILED_COMMANDS=()

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Log file
LOG_FILE="$BASE_DIR/scripts/installer/hyprland-uwsm.log"

if [[ "$AUTO_MODE" == "true" ]]; then
  echo -e "${YELLOW}Running in AUTO mode: all confirmations will be skipped.${NC}"
  echo "$(date): Script started in AUTO mode." >>"$LOG_FILE"
fi

# Trap interruption
function trap_message {
  print_error "\n\nScript interrupted. Exiting.....\n"
  log_message "Script interrupted and exited"
  exit 1
}

# Log message
function log_message {
  echo "$(date): $1" >>"$LOG_FILE"
}

# Print functions
function print_error { echo -e "${RED}$1${NC}"; }
function print_success { echo -e "${GREEN}$1${NC}"; }
function print_warning { echo -e "${YELLOW}$1${NC}"; }
function print_info { echo -e "${BLUE}$1${NC}"; }
function print_bold_blue { echo -e "${BLUE}${BOLD}$1${NC}"; }

# Ask for confirmation (auto-accept in AUTO_MODE)
function ask_confirmation {
  if [[ "$AUTO_MODE" == "true" ]]; then
    log_message "Auto mode enabled: automatically accepting '$1'"
    return 0
  fi

  while true; do
    read -p "$(print_warning "$1 (y/n): ")" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      log_message "Operation accepted by user."
      return 0
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
      log_message "Operation cancelled by user."
      print_error "Operation cancelled."
      return 1
    else
      print_error "Invalid input. Please answer y or n."
    fi
  done
}

# Run command with optional confirmation and retry
function run_command {
  local cmd="$1"
  local description="$2"
  local ask_confirm="${3:-yes}"
  local use_sudo="${4:-yes}"

  local full_cmd=""
  if [[ "$use_sudo" == "no" ]]; then
    full_cmd="sudo -u $SUDO_USER $cmd"
  else
    full_cmd="$cmd"
  fi

  log_message "Attempting to run: $description"
  print_info "\nCommand: $full_cmd"

  if [[ "$ask_confirm" == "yes" ]]; then
    if ! ask_confirmation "$description"; then
      log_message "$description was skipped by user choice."
      return 1
    fi
  else
    print_info "\n$description"
  fi

  while ! eval "$full_cmd"; do
    print_error "❌ $description failed."
    log_message "Command failed: $cmd"
    FAILED_COMMANDS+=("$description")
    print_warning "$description failed and will not be retried (continuing)."
    log_message "$description failed but script will continue (auto mode)."
    return 1
  done

  print_success "✅ $description completed successfully."
  log_message "$description completed successfully."
  return 0
}

# Run script with retry and confirmation
function run_script {
  local script="$BASE_DIR/scripts/installer/$1"
  local description="$2"
  if ask_confirmation "\nExecute '$description' script"; then
    while ! bash "$script"; do
      print_error "$description script failed."
      if ! ask_confirmation "Retry $description"; then
        return 1
      fi
    done
    print_success "\n$description completed successfully."
  else
    return 1
  fi
}

# Root check
function check_root {
  if [ "$EUID" -ne 0 ]; then
    print_error "Please run as root"
    log_message "Script not run as root. Exiting."
    exit 1
  fi
  SUDO_USER=$(logname)
  log_message "Original user is $SUDO_USER"
}

# OS check
function check_os {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "arch" ]]; then
      print_warning "This script is designed for Arch Linux. Your system: $PRETTY_NAME"
      if ! ask_confirmation "Continue anyway?"; then
        log_message "Installation cancelled due to unsupported OS"
        exit 1
      fi
    else
      print_success "Arch Linux detected. Proceeding with installation."
      log_message "Arch Linux detected. Installation proceeding."
    fi
  else
    print_error "Unable to determine OS. /etc/os-release not found."
    if ! ask_confirmation "Continue anyway?"; then
      log_message "Installation cancelled due to unknown OS"
      exit 1
    fi
  fi
}

# Print summary of failed commands at the end
function print_summary {
  echo "------------------------------------------------------------------------"
  if [ ${#FAILED_COMMANDS[@]} -eq 0 ]; then
    print_success "🎉 All commands completed successfully!"
    log_message "Installation completed successfully."
  else
    print_warning "⚠️  Some commands failed during execution:"
    for desc in "${FAILED_COMMANDS[@]}"; do
      echo -e "   - ${RED}$desc${NC}"
    done
    print_info "Check the log file for details: $LOG_FILE"
    log_message "Installation completed with errors."
  fi
}
