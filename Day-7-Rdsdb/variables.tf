variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default = [ "","" ]
}
variable "name" {
    type = string
    default = ""
  
}

variable "vpc_id" {
    type = string
    default = ""
  
}
variable "aws_security_group_name" {
    type = string
    default = ""
  
}
variable "allocated_storage" {
  type        = number
}

variable "storage_type" {
  type        = string
  default     = ""
}

variable "engine" {
  type        = string
  default     = ""
}

variable "engine_version" {
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
  default     = ""
}

variable "identifier" {
  description = "The RDS instance identifier"
  type        = string
  default     = ""
}

variable "username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = ""
}

variable "password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
  default = ""
}


variable "publicly_accessible" {
  description = "Whether the DB should be publicly accessible"
  type        = bool
}

variable "backup_retention_period" {
  description = "The backup retention period in days"
  type        = number
  default     = 7
}
variable "name1" {
    type = string
    default = ""
  
}
