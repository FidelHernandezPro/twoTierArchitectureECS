
variable "environment" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {}
variable "target_port" {
  type    = number
  default = 80
}
