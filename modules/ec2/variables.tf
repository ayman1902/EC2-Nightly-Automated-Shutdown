variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Tag for the EC2 instance name"
  default     = "ExampleInstance"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  default     = "us-east-1a"  # Adjust this based on your preference
}
