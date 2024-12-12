variable "region" {
  description = "AWS region for the VPC."
  default     = "ap-south-1"
}

# variables.tf
variable "task_definitions" {
  description = "List of task definitions to create"
  type = list(object({
    family_name = string
    cpu         = optional(string)
    memory      = optional(string)
    primary_container = object({
      name           = string
      image          = string
      container_port = number
      host_port      = number
    })
    additional_containers = optional(list(object({
      name             = string
      image            = string
      container_port   = optional(number)
      host_port        = optional(number)
      essential        = optional(bool)
      docker_labels    = optional(map(string))
    })))
    tags = optional(map(string))
  }))
}

variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
  default     = "Property-Share-Prod"
}