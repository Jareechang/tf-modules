variable "subnet_public_cidrblock" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
    type = list(string)
}

variable "subnet_private_cidrblock" {
    default = [
        "10.0.11.0/24",
        "10.0.22.0/24"
    ]
    type = list(string)
}

variable "azs" {
    default = [
        "us-east-1a",
        "us-east-1b",
    ]
    type = list(string)
}

variable "project_id" {
    default = "web-app" 
    type = string
}

variable "env" {
    default = "dev" 
    type = string
}
