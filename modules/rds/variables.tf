variable "environment" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "engine_version" {

}
variable "instance_class" {

}
variable "instance_count" {

}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
variable "subnet_group_name" {
}
