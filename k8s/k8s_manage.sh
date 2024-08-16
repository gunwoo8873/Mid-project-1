#!/bin/bash
source ./class_apply.sh
source ./class_delete.sh

# Apply All
apply_all() {
    apply_namespaces
    apply_configmaps
    apply_secrets
    apply_persistent_volumes
    sleep 1
    apply_persistent_volume_claims
    sleep 1
    apply_deployments
    apply_services
    apply_ingresses
    apply_network_policies
    echo "All resources have been applied."
}

# Delete All
delete_all() {
    delete_services
    delete_deployments
    delete_ingresses
    delete_network_policies
    delete_persistent_volume_claims
    sleep 1
    delete_persistent_volumes
    delete_secrets
    delete_configmaps
    delete_namespaces
    echo "All resources have been deleted."
}

# Menu
show_menu() {
    echo "=============================="
    echo "Select a resource:"
    echo "1. Namespaces"
    echo "2. ConfigMaps"
    echo "3. Secrets"
    echo "4. Persistent Volumes"
    echo "5. Persistent Volume Claims"
    echo "6. Deployments"
    echo "7. Services"
    echo "8. Ingresses"
    echo "9. Network Policies"
    echo "all. All resources"
    echo "q. Quit"
    echo "=============================="
}

# Usage
usage() {
    echo "Usage: $0 {menu|apply|delete}"
    exit 1
}

# Main
if [ $# -ne 1 ]; then
    usage
fi

case $1 in
    menu)
        while true; do
            show_menu
            read -p "Choose a resource (1-9, all) or 'q' to quit: " resource
            if [ "$resource" == "q" ]; then
                break
            fi

            read -p "Would you like to apply (a) or delete (d)? " action
            case $resource in
                1) [ "$action" == "a" ] && apply_namespaces || [ "$action" == "d" ] && delete_namespaces ;;
                2) [ "$action" == "a" ] && apply_configmaps || [ "$action" == "d" ] && delete_configmaps ;;
                3) [ "$action" == "a" ] && apply_secrets || [ "$action" == "d" ] && delete_secrets ;;
                4) [ "$action" == "a" ] && apply_persistent_volumes || [ "$action" == "d" ] && delete_persistent_volumes ;;
                5) [ "$action" == "a" ] && apply_persistent_volume_claims || [ "$action" == "d" ] && delete_persistent_volume_claims ;;
                6) [ "$action" == "a" ] && apply_deployments || [ "$action" == "d" ] && delete_deployments ;;
                7) [ "$action" == "a" ] && apply_services || [ "$action" == "d" ] && delete_services ;;
                8) [ "$action" == "a" ] && apply_ingresses || [ "$action" == "d" ] && delete_ingresses ;;
                9) [ "$action" == "a" ] && apply_network_policies || [ "$action" == "d" ] && delete_network_policies ;;
                "all") 
                    if [ "$action" == "a" ]; then
                        apply_all
                    elif [ "$action" == "d" ]; then
                        delete_all
                    else
                        echo "Invalid action. Please enter 'a' or 'd'."
                    fi
                    ;;
                *) echo "Invalid option." ;;
            esac
            read -p "Press Enter to continue..."
        done
        ;;
    apply)
        apply_all
        ;;
    delete)
        delete_all
        ;;
    *)
        usage
        ;;
esac
