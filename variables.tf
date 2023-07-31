variable "vpc_name" {
  description = "this is the VPC name"
  type = string
}

variable "vpc_cidr" {
    description = "CIDR block range of vpc"
}

variable "cidr_public_1" {
    description = "cidr of public"  
}

variable "cidr_private_1" {
    description = "cidr of private"  
}


variable "rtb_public_id" {
    description = "rtb id of public subnet"
}