variable "service_names" {
  description = "List of ECS service names"
  type        = list(string)
  default     = ["service-1", "service-2", "service-3", "service-4", "service-5", "service-6", "service-7", "service-8", "service-9", "service-10", "service-11", "service-12", "service-13"]
}

variable "container_ports" {
  description = "List of container ports for ECS services"
  type        = list(number)
  #default     = [80, 80, 80, 8080, 8080, 8080, 443, 443, 443, 8081, 8081, 8081, 8082]
}

variable "private_subnet_ids" {
  description = "List of subnet IDs to attach the ALB"
  type        = list(string)
}

variable "target_group_arn" {
}

variable "task_definition_arns" {
  description = "Map or list of task definition ARNs"
  type        = map(string)  # or list(string) depending on your preference
}

variable "cluster_name" {
  type = string
}