# What is a Azure Kubernetes Service (AKS)?

- **Azure Kubernetes Service** is a managed container orchestration service based on the open source Kubernetes system. 
- AKS can handle critical functionality such as deploying, scaling and managing Docker containers and container-based applications.
- AKS became generally available in June 2018
- There can be multiple resource group in a single subscription

![Azure Kubernetes Service](https://miro.medium.com/max/1890/1*l6oSrwfJhPXdfA92KYtfzA.png)

You can get the more information [here](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/govern/resource-consistency/resource-access-management)

# What is Azure CLI?

- The Azure Command-Line Interface (CLI) is a cross-platform command-line tool to connect to Azure and execute administrative commands on Azure resources.
- It allows the execution of commands through a terminal using interactive command-line prompts or a script.

You can get the more information [here](https://learn.microsoft.com/en-us/cli/azure/)

# Pre-requsties

- Setup Azure CLI, check for the installation of Azure CLI [here](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

# How to run the script

- Run the script using command `./create-aks.sh`
- Enter the resource group name, location of resource group, vnet name, vnet address prefix (optional), subnet name, address prefix for subnet, aks name, aks network plugin when asked
