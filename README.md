Terraform Azure Infrastructure Deployment

Overview
This repository contains a Terraform script for setting up a network infrastructure and deploying a Check Point Firewall in Azure.  It is meant as a bigginer's guide that could lead to more complex deployments. 

Components
Azure Provider Configuration
Resource Group
Virtual Network
Subnet
Public IP Address
Network Interface 
Check Point Firewall Virtual Machine

Note that you will have to accept the Azure Marketplace terms for this VM:
az vm image terms accept --urn checkpoint:check-point-cg-r8120:sg-byol:latest 