# MongoDB Atlas API Keys
variable "mongodb_atlas_public_key" {
  description = "MongoDB Atlas API Public Key"
  type        = string
  sensitive   = true
}

variable "mongodb_atlas_private_key" {
  description = "MongoDB Atlas API Private Key"
  type        = string
  sensitive   = true
}

variable "mongodb_atlas_org_id" {
  description = "MongoDB Atlas Organization ID"
  type        = string
}

# Project Configuration
variable "project_name" {
  description = "MongoDB Atlas Project Name"
  type        = string
  default     = "cee-backend"
}

variable "cluster_name" {
  description = "MongoDB Atlas Cluster Name"
  type        = string
  default     = "cee-cluster"
}

# Cluster Configuration
variable "cloud_provider" {
  description = "Cloud provider for MongoDB Atlas (AWS, GCP, AZURE)"
  type        = string
  default     = "AWS"
}

variable "region" {
  description = "Region for MongoDB Atlas cluster"
  type        = string
  default     = "AP_SOUTHEAST_1" # Singapore
}

variable "instance_size" {
  description = "Instance size (M0 = free tier, M10+ = paid)"
  type        = string
  default     = "M0" # Free tier
}

variable "mongodb_version" {
  description = "MongoDB major version"
  type        = string
  default     = "7.0"
}

# Database Configuration
variable "database_name" {
  description = "Database name"
  type        = string
  default     = "cee_db"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "cee_admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Network Configuration
variable "ip_access_cidr" {
  description = "CIDR block for IP access (0.0.0.0/0 for all, restrict in production)"
  type        = string
  default     = "0.0.0.0/0"
}

# Environment
variable "environment" {
  description = "Environment (development, staging, production)"
  type        = string
  default     = "development"
}
