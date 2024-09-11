variable "project_name" {
  type        = string
  default     = "vaibhav-gcp-01-433314-t5"
  description = "The name of the project"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The region to deploy the resources to"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "The zone to deploy the resources to"
}   

variable "network" {
  type        = string
  default     = "tf-vpc-network"
  description = "The name of the network to deploy the resources to"
}   

variable "subnetwork" {
  type        = string
  default     = "tf-vpc-subnetwork"
  description = "The name of the subnetwork to deploy the resources to"
}

variable "os_image" {
  type        = string
  default     = "debian-cloud/debian-11"
  description = "The name of the OS image to use"
}

variable "instance_name" {
  type        = string
  default     = "tf-instance"
  description = "The name of the instance"
}   