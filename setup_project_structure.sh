#!/bin/bash

# ev
CURRENT_DIR=$(pwd)
private_files_path="$CURRENT_DIR/project-private-files"
my_project_path="$CURRENT_DIR/project"
branch_name="dev"
repo_backend="--single-branch --branch $branch_name https://github.com/Jake2580/Miniproject-20240703-Backend.git"
repo_frontend="--single-branch --branch $branch_name https://github.com/Jake2580/Miniproject-20240703-Frontend.git"
repo_checkout="dev"
backend_path="$my_project_path/Backend"
frontend_path="$my_project_path/Frontend"
docker_project_name="-p mid"

install_project() {
    if [ -d $my_project_path ]; then
        echo "Project is already installed."
        return 1
    fi

    if [ ! -d $private_files_path ]; then
        echo "Please prepare the configuration file. This is an important file."
        return 1
    fi

    # Download the project.
    mkdir -p $backend_path
    mkdir -p $frontend_path
    git clone $repo_backend $backend_path
    git clone $repo_frontend $frontend_path

    # checkout
    checkout_project

    # Moves project settings and miscellaneous files.
    cp -r $private_files_path/* $my_project_path/

    echo "Project installed successfully."
}

update_project() {
    if [ ! -d $my_project_path ]; then
        echo "Project is not installed. Please run install_project first."
        return 1
    fi

    # Navigate to Backend and Frontend directories and forcefully pull the latest changes.
    cd $backend_path
    git fetch --all
    git reset --hard origin/$branch_name

    cd $frontend_path
    git fetch --all
    git reset --hard origin/$branch_name
    
    # Checkout
    checkout_project

    # Forcefully overwrite settings and miscellaneous files.
    cp -rf $private_files_path/* $my_project_path/

    echo "Project updated successfully."
}

checkout_project() {
    cd $backend_path
    git checkout $repo_checkout > /dev/null 2>&1
    cd $frontend_path
    git checkout $repo_checkout > /dev/null 2>&1
}

delete_project() {
    rm -rf $my_project_path
    echo "Project deleted successfully."
}

delete_project_private_files() {
    rm -rf $private_files_path
    echo "Successfully deleted the project's private files."
}

docker_compose() {
    cd "$my_project_path" || { echo "Directory change failed!"; return 1; }

    case $1 in
        "up_build")
            docker compose $docker_project_name up -d --build
            ;;
        "build")
            docker compose $docker_project_name build
            ;;
        "up")
            docker compose $docker_project_name up -d
            ;;
        "stop")
            docker compose $docker_project_name stop
            ;;
        "down")
            docker compose $docker_project_name down
            ;;
        *)
            echo "Invalid option. Please choose one of 'up_build', 'up', 'stop', 'down'."
            cd "$CURRENT_DIR" || return
            return 1
            ;;
    esac

    cd "$CURRENT_DIR" || return
}

while true; do
    clear
    echo "Select an option:"
    echo "1. Download Project"
    echo "2. Docker compose build."
    echo "u. Update Project"
    echo "d. DELETE PROJECT"
    echo "dd. DELETE PRIVATE FILES"
    echo "0. Exit Script"
    read -p "Choice: " choice

    case $choice in
        1)
            echo "Download Project..."
            install_project
            ;;
        2)
            echo "Docker compose build..."
            docker_compose build
            ;;
        "u")
            echo "Update Project..."
            update_project
            ;;
        "d")
            echo "Delete Project......"
            delete_project
            ;;
        "dd")
            echo "Delete Project private files......"
            delete_project_private_files
            ;;
        0)
            echo "Exiting script."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done
