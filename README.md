Terraform Azure Infrastructure Deployment

Overview
This repository contains a Terraform script for setting up a network infrastructure and deploying a Check Point Firewall in Azure.  It is meant as a bigginer's guide that could lead to more complex deployments. 

Components
Azure Provider Configuration: Sets up the provider for Azure resources.
Resource Group: Creates an Azure resource group named 'VT-resources'.
Virtual Network: Establishes a virtual network with specified address space.
Subnet: Configures a subnet within the virtual network.
Public IP Address: Allocates a static public IP address.
Network Interface: Sets up a network interface with dynamic IP allocation and associates it with the public IP.
Check Point Firewall Virtual Machine: Deploys a VM with the Check Point Firewall image from Azure Marketplace.

Usage
Initialize Terraform: terraform init
Review changes with Plan: terraform plan - This step shows you what Terraform will do without making any changes. It's a good practice to always run and review the plan.
Apply configuration: terraform apply - This step actually creates or updates the infrastructure.
Remember to review the Terraform plan output carefully before applying, as it gives you an opportunity to catch any unintended changes.