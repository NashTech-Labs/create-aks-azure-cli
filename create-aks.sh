#!/bin/sh

set -o errexit
set -o xtrace  # used for debugging

##################################################

# Variables for Azure Resource Group
echo "\nEnter Resource Group Name: "
read rg_name

echo "\nEnter Resource Group Location: "
read rg_location

# Create Azure Resource Group
echo "Creating an Azure Resource Group"
create_rg_status=$(az group create \
    --name $rg_name \
    --location $rg_location)

# check status code for resource group creation
create_rg_status_code=$?

[ $create_rg_status_code -eq 0 ] && echo "\nResource Group Created" || echo "\nError creating Resource Group \n $create_rg_status"

##################################################

# Variables for Azure Vnet
echo "\nEnter VNet Name: "
read vnet_name

echo "\nEnter VNet Address Prefix: "
read vnet_address_prefix

# Create Azure Vnet
echo "Creating an Azure VNet"

if [ -z "$vnet_address_prefix" ]
then
    create_vnet_status=$(az network vnet create \
        --resource-group $rg_name \
        --name $vnet_name)
else
    create_vnet_status=$(az network vnet create \
        --resource-group $rg_name \
        --name $vnet_name \
        --address-prefixes $vnet_address_prefix)
fi

# check status code for vnet creation
create_vnet_status_code=$?

[ $create_vnet_status_code -eq 0 ] && echo "\nVNet Created" || echo "\nError creating VNet \n $create_vnet_status"

##################################################

# Variables for Azure Subnet
echo "\nEnter Subnet Name: "
read subnet_name

echo "\nEnter Subnet Address Prefix: "
read subnet_address_prefix

# Create Azure VNet Subnet
echo "Creating an Azure VNet Subnet"

create_subnet_status=$(az network vnet subnet create \
    --resource-group $rg_name \
    --vnet-name $vnet_name \
    --name $subnet_name \
    --address-prefixes $subnet_address_prefix)

# check status code for subnet creation
create_subnet_status_code=$?

[ $create_subnet_status_code -eq 0 ] && echo "\nSubnet Created" || echo "\nError creating Subnet \n $create_subnet_status"


# Get Subnet ID
subnet_id=$(az network vnet subnet show \
    --resource-group $rg_name \
    --vnet-name $vnet_name \
    --name $subnet_name \
    --query id \
    -o tsv)

##################################################

# Variables for AKS
echo "\nEnter AKS Name: "
read aks_name

echo "\nEnter Node Count: "
read aks_node_count

echo "\nEnter Netwrok Plugin for AKS Cluster: "
read aks_network_plugin

# Create AKS
echo "Creating AKS Cluster"
create_aks_status=$(az aks create \
    --resource-group $rg_name \
    --name $aks_name \
    --node-count $aks_node_count \
    --network-plugin $aks_network_plugin \
    --vnet-subnet-id $subnet_id \
    --generate-ssh-keys )

# check status code for aks creation
create_aks_status_code=$?

[ $create_aks_status_code -eq 0 ] && echo "\nAKS Created" || echo "\nError creating AKS \n $create_aks_status"
