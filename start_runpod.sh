#!/bin/bash

set -e  # Exit the script if any statement returns a non-true return value

# ---------------------------------------------------------------------------- #
#                          Function Definitions                                #
# ---------------------------------------------------------------------------- #

# Start nginx service
start_nginx() {
    echo "Starting Nginx service..."
    service nginx start
}

# Execute script if exists
execute_script() {
    local script_path=$1
    local script_msg=$2
    if [[ -f ${script_path} ]]; then
        echo "${script_msg}"
        bash ${script_path}
    fi
}

# Setup ssh
setup_ssh() {
    if [[ $PUBLIC_KEY ]]; then
        echo "Setting up SSH..."
        mkdir -p ~/.ssh
        echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
        chmod 700 -R ~/.ssh
        service ssh start
    fi
}

# ---------------------------------------------------------------------------- #
#                               Read Arguments                                 #
# ---------------------------------------------------------------------------- #

ID=""
HOSTING_ENTITY=""
NUM_PARALLEL_RUNS=1

# Parse flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --id) ID="$2"; shift ;;
        --hosting_entity) HOSTING_ENTITY="$2"; shift ;;
        --num_parallel_runs) NUM_PARALLEL_RUNS="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# ---------------------------------------------------------------------------- #
#                               Main Program                                   #
# ---------------------------------------------------------------------------- #


start_nginx

execute_script "pre_start.sh" "Running pre-start script..."
echo "Pod Started"

setup_ssh

execute_script "post_start.sh" "Running post-start script..."

sleep infinity