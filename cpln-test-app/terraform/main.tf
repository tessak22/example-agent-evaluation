terraform {
  required_providers {
    cpln = {
      source  = "controlplane-com/cpln"
      version = "~> 1.0"
    }
  }
}

provider "cpln" {
  org = var.org
}

variable "org" {
  description = "Control Plane organization name"
  type        = string
}

variable "gvc_name" {
  description = "Name of the Global Virtual Cloud"
  type        = string
  default     = "production"
}

variable "locations" {
  description = "Deployment locations"
  type        = list(string)
  default     = ["aws-us-west-2", "aws-us-east-1"]
}

# Create the GVC (environment)
resource "cpln_gvc" "main" {
  name        = var.gvc_name
  description = "Production environment"

  locations = var.locations
}

# Create a secret for the database connection
resource "cpln_secret" "database_url" {
  name        = "database-url"
  description = "PostgreSQL connection string"

  opaque {
    payload  = "postgresql://user:pass@my-rds-instance.us-west-2.rds.amazonaws.com:5432/mydb"
    encoding = "plain"
  }
}

# Create a secret for Redis
resource "cpln_secret" "redis_url" {
  name        = "redis-url"
  description = "Redis connection string"

  opaque {
    payload  = "redis://my-elasticache.us-west-2.cache.amazonaws.com:6379"
    encoding = "plain"
  }
}

# Create an identity for the API workload to access secrets
resource "cpln_identity" "api" {
  gvc  = cpln_gvc.main.name
  name = "api-identity"
}

# Create the API workload
resource "cpln_workload" "api" {
  gvc  = cpln_gvc.main.name
  name = "api"

  type = "serverless"

  container {
    name   = "api"
    image  = "your-org.registry.cpln.io/api:latest"
    cpu    = "100m"
    memory = "256Mi"

    port {
      protocol = "http"
      number   = 8080
    }

    env = {
      NODE_ENV     = "production"
      PORT         = "8080"
      DATABASE_URL = "cpln://secret/database-url"
      REDIS_URL    = "cpln://secret/redis-url"
    }

    readiness_probe {
      tcp_socket {
        port = 8080
      }
    }
  }

  options {
    autoscaling {
      metric     = "concurrency"
      target     = 100
      min_scale  = 0
      max_scale  = 10
    }

    capacity_ai = true
  }

  firewall_spec {
    external {
      inbound_allow_cidr = ["0.0.0.0/0"]
      outbound_allow_cidr = ["0.0.0.0/0"]
    }
    internal {
      inbound_allow_type = "same-gvc"
    }
  }

  identity_link = cpln_identity.api.self_link
}

# Create the worker workload (background jobs)
resource "cpln_workload" "worker" {
  gvc  = cpln_gvc.main.name
  name = "worker"

  type = "standard"

  container {
    name   = "worker"
    image  = "your-org.registry.cpln.io/worker:latest"
    cpu    = "200m"
    memory = "512Mi"

    env = {
      NODE_ENV     = "production"
      DATABASE_URL = "cpln://secret/database-url"
      REDIS_URL    = "cpln://secret/redis-url"
    }
  }

  options {
    autoscaling {
      min_scale = 1
      max_scale = 3
    }

    capacity_ai = true
  }

  firewall_spec {
    external {
      outbound_allow_cidr = ["0.0.0.0/0"]
    }
    internal {
      inbound_allow_type = "same-gvc"
    }
  }

  identity_link = cpln_identity.api.self_link
}

output "api_endpoint" {
  value       = cpln_workload.api.status[0].endpoint
  description = "Public endpoint for the API"
}
