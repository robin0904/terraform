# terraform.tfvars
task_definitions = [
  {
    family_name = "altcapital_old_dashboard_web"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "altcapital-dashboard-web"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/altcapital_old_dashboard_web"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "altcapital_web"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "altcapital-web"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/alt_capital_web"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "auth_service"
    cpu         = "2048"
    memory      = "4096"
    primary_container = {
      name           = "ps-auth-servicex"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/auth_service"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "distributor_dashboard_wa"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "ps-distributor-dashboard"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/distributor_dashboard_wa"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
    {
    family_name = "distributor_service"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "ps-distributor-service"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/distributor_service"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "im_web"
    cpu         = "2048"
    memory      = "4096"
    primary_container = {
      name           = "smreit-web"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/im_web"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "prod-ecs-prometheus-task"
    cpu         = "2048"
    memory      = "4096"
    primary_container = {
      name           = "prometheus-container"
      image          = "tkgregory/prometheus-with-remote-configuration:latest"
      container_port = 9090
      host_port      = 9090
    }
    additional_containers = [
      {
        name             = "prometheus-service-discovery"
        image            = "tkgregory/prometheus-ecs-discovery:latest"
        container_port   = null
        host_port        = null
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "prod-engagement"
    cpu         = "2048"
    memory      = "4096"
    primary_container = {
      name           = "php-kafka-engagement"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/prod-engagement"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },
  {
    family_name = "propshare_platina_web"
    cpu         = "512"
    memory      = "1024"
    primary_container = {
      name           = "propshare-platina-web"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/propshare_platina_web"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },

  {
    family_name = "psreit_web"
    cpu         = "512"
    memory      = "1024"
    primary_container = {
      name           = "psreit-web"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/propshare_platina_web"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },

  {
    family_name = "rent_management_service"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "ps-rent-management-service"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/rent_management_service"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },

  {
    family_name = "reporting_service"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "ps-reporting-service"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/reporting_service"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  },

  {
    family_name = "support_service"
    cpu         = "1024"
    memory      = "2048"
    primary_container = {
      name           = "ps-support-service"
      image          = "225558281521.dkr.ecr.ap-south-1.amazonaws.com/support_service"
      container_port = 80
      host_port      = 80
    }
    additional_containers = [
      {
        name             = "ecs-exporter"
        image            = "quay.io/prometheuscommunity/ecs-exporter:latest"
        container_port   = 9779
        host_port        = 9779
        essential        = false
        docker_labels    = {
          "PROMETHEUS_EXPORTER_PATH" = "/metrics"
          "PROMETHEUS_EXPORTER_PORT" = "9779"
        }
      }
    ]
    tags = {
      "functionality" = "Automation And Orchestration"
    }
  }

  # You can add up to 13 task definitions here
]