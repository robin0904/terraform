variable "lb_name" {
  description = "Name of the Network Load Balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach the NLB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the NLB will be created"
  type        = string
}

variable "target_groups" {
  description = "Map of target groups to create"
  type = map(object({
    port         = number
    target_type  = string
    health_check_port = optional(number)
  }))
}