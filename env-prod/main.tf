module "vpc" {
  source                = "../modules/vpc"
  cidr_block            = "10.0.0.0/16"
  name                  = "prod-web"
  public_subnet_cidrs   = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_cidrs  = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
}

module "prod_common_nlb" {
  source = "../modules/nlb"
  
  lb_name     = "prod-common-nlb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids

  target_groups = {
    "auth-service-com-tg" = {
      port         = 8085
      target_type  = "ip"
    },
    "prod-api-svc-com-tg" = {
      port         = 8080
      target_type  = "instance"
    },
    "prod-distributor-svc-com-tg" = {
      port         = 8081
      target_type  = "ip"
    },
    "prod-engagement-svc-com-tg" = {
      port         = 8082
      target_type  = "ip"
    },
    "prod-reporting-svc-com-tg" = {
      port         = 8083
      target_type  = "ip"
    },
    "prod-support-svc-com-tg" = {
      port         = 8084
      target_type  = "ip"
    },
    "rent-management-service-tg" = {
      port         = 8086
      target_type  = "ip"
    }
  }
}

module "prod_api_tg_new" {
  source = "../modules/nlb"
  
  lb_name     = "prod-api-tg-new"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids

  target_groups = {
    "prod-api-tg-new" = {
      port         = 80
      target_type  = "instance"
    }
  }
}

# Previous NLB configurations...

module "prod_administrator_alb" {
  source = "../modules/alb"
  
  lb_name     = "prod-administrator-alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  target_groups = {
    "prod-administrator-tg" = {
      port = 80
      target_type = "instance"
      health_check_path = "/health"  # Adjust as needed
    }
  }
  
  http_listener_enabled = true
  https_listener_enabled = true
  certificate_arn = "arn:aws:acm:ap-south-1:225558281521:certificate/4c04a565-b562-4b5e-bf62-780ecb465135"  # Replace with actual certificate ARN
  
  https_host_rules = {
    "admin.propertyshare.in" = {
      priority = 100
      action_type = "forward"
      target_group = "prod-administrator-tg"
    }
  }
}

module "prod_ecs_observability_alb" {
  source = "../modules/alb"
  
  lb_name     = "prod-ecs-observability-alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  
  target_groups = {
    "prod-ecs-observability-tg" = {
      port = 80
      target_type = "ip"
      health_check_path = "/health"
    }
  }
  
  default_target_group = "prod-ecs-observability-tg"
  http_listener_enabled = true
}

module "prod_web_alb" {
  source = "../modules/alb"
  
  lb_name     = "prod-web-alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  
  target_groups = {
    "altcapital-old-dashboard-web-tg" = {
      port = 80
      target_type = "ip"
    },
    "altcapital-web-tg" = {
      port = 80
      target_type = "ip"
    },
    "im-web-tg" = {
      port = 80
      target_type = "ip"
    },
    "prod-distributor-dashboard-wa" = {
      port = 80
      target_type = "ip"
    },
    "prod-web-pscap-tg" = {
      port = 80
      target_type = "ip"
    },
    "propshare-platina-web-tg" = {
      port = 80
      target_type = "ip"
    },
    "psreit-web-tg" = {
      port = 80
      target_type = "ip"
    }
  }
  
  http_listener_enabled = true
  https_listener_enabled = true
  certificate_arn = "arn:aws:acm:ap-south-1:225558281521:certificate/4c04a565-b562-4b5e-bf62-780ecb465135"  # Replace with actual certificate ARN
  
  https_host_rules = {
    "propshareconnect.propertyshare.in" = {
      priority = 100
      action_type = "forward"
      target_group = "prod-distributor-dashboard-wa"
    },
    "www.propertyshare.in" = {
      priority = 110
      action_type = "forward"
      target_group = "im-web-tg"
    },
    "www.propsharecapital.com" = {
      priority = 120
      action_type = "redirect"
      redirect_host = "www.altcapital.ai"
      redirect_status_code = "HTTP_301"
    },
    "dashboard.propsharecapital.com" = {
      priority = 130
      action_type = "redirect"
      redirect_host = "dashboard.altcapital.ai"
      redirect_status_code = "HTTP_301"
    },
    "globalreit.propsharecapital.com" = {
      priority = 140
      action_type = "forward"
      target_group = "prod-web-pscap-tg"
    },
    "dashboard1.propsharecapital.com" = {
      priority = 150
      action_type = "redirect"
      redirect_host = "dashboard1.altcapital.ai"
      redirect_status_code = "HTTP_301"
    },
    "www.psreit.in" = {
      priority = 160
      action_type = "forward"
      target_group = "psreit-web-tg"
    },
    "www.altcapital.ai" = {
      priority = 170
      action_type = "forward"
      target_group = "altcapital-web-tg"
    },
    "dashboard1.altcapital.ai" = {
      priority = 180
      action_type = "forward"
      target_group = "altcapital-old-dashboard-web-tg"
    },
    "www.propshareplatina.in" = {
      priority = 190
      action_type = "redirect"
      redirect_host = "www.propshareplatina.com"
      redirect_status_code = "HTTP_301"
    },
    "www.propshareplatina.com" = {
      priority = 200
      action_type = "forward"
      target_group = "propshare-platina-web-tg"
    }
  }
}

# main.tf
module "ecs_task_definitions" {
  source   = "../modules/ecs_task_definition"
  count    = length(var.task_definitions)

  family_name     = var.task_definitions[count.index].family_name
  cpu             = lookup(var.task_definitions[count.index], "cpu", "1024")
  memory          = lookup(var.task_definitions[count.index], "memory", "2048")

  primary_container = {
    name           = var.task_definitions[count.index].primary_container.name
    image          = var.task_definitions[count.index].primary_container.image
    container_port = var.task_definitions[count.index].primary_container.container_port
    host_port      = var.task_definitions[count.index].primary_container.host_port
  }

  additional_containers = lookup(var.task_definitions[count.index], "additional_containers", [])
  
  tags = merge(
    { 
      "Environment" = "Production" 
    },
    lookup(var.task_definitions[count.index], "tags", {})
  )
}