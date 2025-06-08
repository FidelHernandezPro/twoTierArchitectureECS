variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "rds_arn" {
  type = string
}

variable "backup_role_arn" {
  type = string
}
