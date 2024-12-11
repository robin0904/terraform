# modules/ecs_task_definition/variables.tf

variable "family_name" {
  description = "Family name for the task definition"
  type        = string
}

variable "cpu" {
  description = "CPU units for the task"
  type        = string
  default     = "1024"
}

variable "memory" {
  description = "Memory for the task"
  type        = string
  default     = "2048"
}

variable "task_role_arn" {
  description = "Task role ARN"
  type        = string
  default     = "arn:aws:iam::225558281521:role/ecsTaskExecutionRole"
}

variable "execution_role_arn" {
  description = "Execution role ARN"
  type        = string
  default     = "arn:aws:iam::225558281521:role/ecsTaskExecutionRole"
}

variable "log_region" {
  description = "AWS region for logs"
  type        = string
  default     = "ap-south-1"
}

variable "primary_container" {
  description = "Primary container configuration"
  type = object({
    name             = string
    image            = string
    container_port   = number
    host_port        = number
  })
}

variable "additional_containers" {
  description = "Additional containers for the task definition"
  type = list(object({
    name             = string
    image            = string
    container_port   = optional(number)
    host_port        = optional(number)
    essential        = optional(bool, false)
    docker_labels    = optional(map(string), {})
  }))
  default = []
}

variable "tags" {
  description = "Additional tags for the task definition"
  type        = map(string)
  default     = {}
}