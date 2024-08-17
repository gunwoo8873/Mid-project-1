#!/bin/bash

delete_namespaces() {
    echo "Deleting Namespaces..."
    kubectl delete -f namespaces/
}

delete_configmaps() {
    echo "Deleting ConfigMaps..."
    kubectl delete -f configmaps/
}

delete_secrets() {
    echo "Deleting Secrets..."
    kubectl delete -f secrets/
}

delete_persistent_volumes() {
    echo "Deleting Persistent Volumes..."
    kubectl delete -f persistent-volumes/
}

delete_persistent_volume_claims() {
    echo "Deleting Persistent Volume Claims..."
    kubectl delete -f persistent-volume-claims/
}

delete_deployments() {
    echo "Deleting Deployments..."
    kubectl delete -f deployments/
}

delete_services() {
    echo "Deleting Services..."
    kubectl delete -f services/
}

delete_ingresses() {
    echo "Deleting Ingresses..."
    kubectl delete -f ingresses/
}

delete_network_policies() {
    echo "Deleting Network Policies..."
    kubectl delete -f network-policies/
}