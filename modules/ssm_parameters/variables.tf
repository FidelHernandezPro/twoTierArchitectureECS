variable "parameters" {
  description = "Map of parameter names to values"
  type        = map(string)
}

variable "environment" {
  description = "Environment tag for parameters"
  type        = string
}
