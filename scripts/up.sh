#!/bin/bash

export PUID=$(id -u)
export PGID=$(id -g)

# Get the current directory
current_dir=$(realpath "$(dirname "$0")/..")

# load_environment_variables
load_env() {
    local path=$1

    if [ -f "$path/.env" ]; then
        set -o allexport
        source "$path/.env"
        set +o allexport
    fi

    export STACK_NAME_PREFIX=${STACK_NAME_PREFIX:-homelab}
}


start_docker_compose() {
    local service_dir=$1
    local stack_name=$(basename "$service_dir")

    if [ -f "$service_dir/docker-compose.yml" ]; then
        echo "Starting Docker Compose in $service_dir"

        # Navigate to the service directory
        cd "$service_dir" || exit
        
        load_env .homelab

        # Set the stack name with prefix
        export COMPOSE_PROJECT_NAME="$STACK_NAME_PREFIX-${stack_name}"
        
        docker compose pull

        # Start Docker Compose in detached mode
        if [ -f ".homelab/.env" ]; then

            docker compose \
                --env-file $current_dir/.env \
                --env-file ../.env \
                --env-file .homelab/.env \
                up -d
        else
            docker compose \
                --env-file $current_dir/.env \
                --env-file ../.env \
                up -d
        fi
         
        # Unset the COMPOSE_PROJECT_NAME variable to avoid affecting other directories
        unset COMPOSE_PROJECT_NAME
        
        # Return to the original directory
        cd - > /dev/null
    fi
}

start_services() {
    local path=$1

    load_env $path

    # Check if the path exists and is a directory
    if [ ! -d "$path" ]; then
        echo "Error: Directory $path does not exist."
        return 1
    fi

    # Loop through all directories in the given path
    for service_dir in "$path"/*/; do
        # Remove trailing slash from directory name
        service_dir=${service_dir%/}

        # Check if it's a directory and contains a docker-compose.yml file
        if [ -d "$service_dir" ] && [ -f "$service_dir/docker-compose.yml" ]; then
            start_docker_compose "$service_dir"
        fi
    done
}

main() {
    load_env $current_dir
    start_services "$current_dir/services"
    start_services "$current_dir/services/beta"
}

main