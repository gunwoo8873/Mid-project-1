#!/bin/bash

apply_namespaces() {
    echo "Applying Namespaces..."
    kubectl apply -f namespaces/
}

apply_configmaps() {
    echo "Applying ConfigMaps..."
    kubectl apply -f configmaps/
}

apply_secrets() {
    echo "Applying Secrets..."
    kubectl apply -f secrets/
}

apply_persistent_volumes() {
    echo "Applying Persistent Volumes..."
    kubectl apply -f persistent-volumes/
}

apply_persistent_volume_claims() {
    echo "Applying Persistent Volume Claims..."
    kubectl apply -f persistent-volume-claims/
}

apply_deployments() {
    echo "Applying Deployments..."
    kubectl apply -f deployments/
}

apply_services() {
    echo "Applying Services..."
    kubectl apply -f services/
}

apply_ingresses() {
    echo "Applying Ingresses..."
    kubectl apply -f ingresses/
}

apply_network_policies() {
    echo "Applying Network Policies..."
    kubectl apply -f network-policies/
}