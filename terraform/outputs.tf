# Connection String (Standard)
output "connection_string_standard" {
  description = "MongoDB connection string (standard)"
  value       = mongodbatlas_cluster.cee_cluster.connection_strings[0].standard
  sensitive   = true
}

# Connection String (SRV)
output "connection_string_srv" {
  description = "MongoDB connection string (SRV format for Prisma)"
  value       = mongodbatlas_cluster.cee_cluster.connection_strings[0].standard_srv
  sensitive   = true
}

# Full DATABASE_URL for .env file
output "database_url" {
  description = "Full DATABASE_URL for .env file (use with Prisma)"
  value       = replace(
    mongodbatlas_cluster.cee_cluster.connection_strings[0].standard_srv,
    "mongodb+srv://",
    "mongodb+srv://${var.db_username}:${var.db_password}@"
  )
  sensitive   = true
}

# Cluster Info
output "cluster_name" {
  description = "MongoDB Atlas cluster name"
  value       = mongodbatlas_cluster.cee_cluster.name
}

output "cluster_state" {
  description = "MongoDB Atlas cluster state"
  value       = mongodbatlas_cluster.cee_cluster.state_name
}

output "mongodb_version" {
  description = "MongoDB version"
  value       = mongodbatlas_cluster.cee_cluster.mongo_db_version
}

# Project Info
output "project_id" {
  description = "MongoDB Atlas project ID"
  value       = mongodbatlas_project.cee_project.id
}
