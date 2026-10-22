variable "instance_type" {
    description = "Instance type for instance"
    type = string
    default = "t3.micro"
  
}

variable "ami" {
    description = "Ami for instance"
    type = string
    default = "ami-08c46876c64a927b8"
  
}

variable "key" {
    description = "key for instance"
    type = string
    default = "drup-vergina"
  
}

variable "port_nu" {
    description = "Port number for instance"
    type = list(number)
    default = [22,80,]
}