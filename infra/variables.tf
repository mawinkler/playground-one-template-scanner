variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "account_id" {
  type = string
}

variable "access_ip" {
  type = list(any)
}

variable "environment" {
  type = string
}

variable "one_path" {
  type = string
}

variable "xdr_for_containers" {
  type = bool
}
