output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

# New NLB Outputs
output "prod_common_nlb_arn" {
  value = module.prod_common_nlb.nlb_arn
}

output "prod_common_nlb_dns_name" {
  value = module.prod_common_nlb.nlb_dns_name
}

output "prod_common_nlb_target_group_arns" {
  value = module.prod_common_nlb.target_group_arns
}

output "prod_api_tg_new_nlb_arn" {
  value = module.prod_api_tg_new.nlb_arn
}

output "prod_api_tg_new_nlb_dns_name" {
  value = module.prod_api_tg_new.nlb_dns_name
}

output "prod_api_tg_new_target_group_arns" {
  value = module.prod_api_tg_new.target_group_arns
}

# Previous outputs...

# New ALB Outputs
output "prod_administrator_alb_arn" {
  value = module.prod_administrator_alb.alb_arn
}

output "prod_administrator_alb_dns_name" {
  value = module.prod_administrator_alb.alb_dns_name
}

output "prod_administrator_target_group_arns" {
  value = module.prod_administrator_alb.target_group_arns
}

output "prod_ecs_observability_alb_arn" {
  value = module.prod_ecs_observability_alb.alb_arn
}

output "prod_ecs_observability_alb_dns_name" {
  value = module.prod_ecs_observability_alb.alb_dns_name
}

output "prod_ecs_observability_target_group_arns" {
  value = module.prod_ecs_observability_alb.target_group_arns
}

output "prod_web_alb_arn" {
  value = module.prod_web_alb.alb_arn
}

output "prod_web_alb_dns_name" {
  value = module.prod_web_alb.alb_dns_name
}

output "prod_web_target_group_arns" {
  value = module.prod_web_alb.target_group_arns
}
