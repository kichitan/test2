variable "region" {}
variable "project_name" {}
variable "env" {}
variable "azs" {
  type = list(any)
}
variable "vpc_cidr" {}
