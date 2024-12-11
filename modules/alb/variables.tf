variable "lb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}

variable "target_groups" {
  description = "Map of target groups to create"
  type = map(object({
    port             = number
    target_type      = string
    health_check_path = optional(string)
  }))
  default = {}
}

variable "http_listener_enabled" {
  description = "Enable HTTP listener"
  type        = bool
  default     = false
}

variable "https_listener_enabled" {
  description = "Enable HTTPS listener"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
  default     = null
}

variable "https_host_rules" {
  description = "Map of HTTPS host-based routing rules"
  type = map(object({
    priority             = number
    action_type          = string
    target_group         = optional(string)
    redirect_host        = optional(string)
    redirect_port        = optional(number)
    redirect_protocol    = optional(string)
    redirect_status_code = optional(string)
  }))
  default = {}
}

variable "default_target_group" {
  description = "Default target group for HTTP listener. If null, will redirect to HTTPS"
  type        = string
  default     = null
}