# modules/ecs_cluster/variables.tf
variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable container insights"
  type        = bool
  default     = true
}

variable "capacity_providers" {
  description = "List of capacity providers to enable"
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
}

variable "default_capacity_strategy" {
  description = "Default capacity provider strategies for each provider"
  type = list(object({
    capacity_provider = string
    weight            = optional(number, 100)
    base              = optional(number, 1)
  }))
  default = [
    {
      capacity_provider = "FARGATE"
      weight            = 100
      base              = 1
    },
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = 50
      base              = null
    }
  ]
}


variable "tags" {
  description = "Additional tags for the ECS cluster"
  type        = map(string)
  default     = {}
}