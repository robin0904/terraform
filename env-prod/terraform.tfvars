# terraform.tfvars
task_definitions = [
  {
    family_name = "altcapital-dashboard-web-1"
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
      "Project" = "AltCapital"
      "Service" = "Dashboard"
    }
  },
  {
    family_name = "altcapital-dashboard-web-2"
    cpu         = "2048"
    memory      = "4096"
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
      "Project" = "AltCapital"
      "Service" = "Dashboard-Staging"
    }
  }
  # You can add up to 13 task definitions here
]