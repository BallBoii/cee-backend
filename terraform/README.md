# Terraform - MongoDB Atlas Setup

This Terraform configuration provisions a MongoDB Atlas cluster for the CEE Backend.

## Prerequisites

1. **MongoDB Atlas Account**: Create a free account at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. **Terraform**: Install Terraform v1.0+ from [terraform.io](https://www.terraform.io/downloads)
3. **API Keys**: Create API keys in MongoDB Atlas

## Getting MongoDB Atlas API Keys

1. Log in to [MongoDB Atlas](https://cloud.mongodb.com)
2. Click **Access Manager** in the top navigation
3. Select **Organization Access** → **API Keys**
4. Click **Create API Key**
5. Give it a description and select **Organization Owner** permission
6. Copy the **Public Key** and **Private Key**
7. Add your IP address to the API Access List

## Getting Organization ID

1. In MongoDB Atlas, click on **Settings** (gear icon) in the left sidebar
2. Copy the **Organization ID**

## Setup Instructions

### 1. Create terraform.tfvars

```bash
cp terraform.tfvars.example terraform.tfvars
```

### 2. Edit terraform.tfvars

Fill in your values:

```hcl
mongodb_atlas_public_key  = "xxxxxxxx"
mongodb_atlas_private_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
mongodb_atlas_org_id      = "xxxxxxxxxxxxxxxxxxxxxxxx"
db_password               = "your-secure-password"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Plan

```bash
terraform plan
```

### 5. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted.

### 6. Get Connection String

After successful apply:

```bash
# Get the DATABASE_URL for your .env file
terraform output -raw database_url
```

### 7. Update .env File

Copy the connection string and update your `.env`:

```bash
DATABASE_URL="mongodb+srv://cee_admin:your-password@cee-cluster.xxxxx.mongodb.net/cee_db?retryWrites=true&w=majority"
```

## Available Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `mongodb_atlas_public_key` | Atlas API public key | (required) |
| `mongodb_atlas_private_key` | Atlas API private key | (required) |
| `mongodb_atlas_org_id` | Atlas organization ID | (required) |
| `project_name` | Project name | `cee-backend` |
| `cluster_name` | Cluster name | `cee-cluster` |
| `cloud_provider` | Cloud provider | `AWS` |
| `region` | Region | `AP_SOUTHEAST_1` |
| `instance_size` | Instance size | `M0` (free tier) |
| `mongodb_version` | MongoDB version | `7.0` |
| `database_name` | Database name | `cee_db` |
| `db_username` | Database user | `cee_admin` |
| `db_password` | Database password | (required) |
| `ip_access_cidr` | IP whitelist | `0.0.0.0/0` |

## Instance Sizes

| Size | Type | RAM | Storage |
|------|------|-----|---------|
| M0 | Free Tier | Shared | 512 MB |
| M10 | Dedicated | 2 GB | 10 GB |
| M20 | Dedicated | 4 GB | 20 GB |
| M30 | Dedicated | 8 GB | 40 GB |

## Regions

Common regions:
- `US_EAST_1` - N. Virginia
- `US_WEST_2` - Oregon
- `EU_WEST_1` - Ireland
- `AP_SOUTHEAST_1` - Singapore
- `AP_NORTHEAST_1` - Tokyo

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Security Notes

⚠️ **For Production:**

1. **Restrict IP Access**: Change `ip_access_cidr` from `0.0.0.0/0` to specific IPs
2. **Use Strong Passwords**: Generate secure passwords
3. **Use Dedicated Clusters**: M10+ for production workloads
4. **Enable Backup**: Configure automated backups
5. **Use VPC Peering**: For private network access

## Troubleshooting

### "Cluster already exists"
The cluster name must be unique. Change `cluster_name` in your tfvars.

### "IP not whitelisted"
Add your current IP to the Atlas API access list.

### "Insufficient permissions"
Ensure your API key has "Organization Owner" or "Organization Project Creator" permissions.
