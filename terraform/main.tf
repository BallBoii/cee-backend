terraform {
  required_version = ">= 1.0"

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.14"
    }
  }
}

# MongoDB Atlas Provider
provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

# MongoDB Atlas Project
resource "mongodbatlas_project" "cee_project" {
  name   = var.project_name
  org_id = var.mongodb_atlas_org_id
}

# MongoDB Atlas Cluster (Free Tier M0)
resource "mongodbatlas_cluster" "cee_cluster" {
  project_id = mongodbatlas_project.cee_project.id
  name       = var.cluster_name

  # Free tier configuration
  provider_name               = "TENANT"
  backing_provider_name       = var.cloud_provider
  provider_region_name        = var.region
  provider_instance_size_name = var.instance_size

  # Auto-scaling (disabled for free tier)
  auto_scaling_disk_gb_enabled = false
}

# Database User
resource "mongodbatlas_database_user" "cee_user" {
  username           = var.db_username
  password           = var.db_password
  project_id         = mongodbatlas_project.cee_project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.database_name
  }

  roles {
    role_name     = "dbAdmin"
    database_name = var.database_name
  }

  scopes {
    name = mongodbatlas_cluster.cee_cluster.name
    type = "CLUSTER"
  }
}

# IP Access List (allow all for development - restrict in production)
resource "mongodbatlas_project_ip_access_list" "cee_access" {
  project_id = mongodbatlas_project.cee_project.id
  cidr_block = var.ip_access_cidr
  comment    = "Access for CEE Backend"
}
