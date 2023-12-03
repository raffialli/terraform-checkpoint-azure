variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
   //  No defaul value here to ensure it is supplied in the tfvars file
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
   //  No defaul value here to ensure it is supplied in the tfvars file
}