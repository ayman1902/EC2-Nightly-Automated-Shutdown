# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Modify this CIDR block as needed
  tags = {
    Name = "${var.instance_name}-VPC"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # Modify this CIDR block as needed
  availability_zone      = var.availability_zone   # Make this a variable if needed
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.instance_name}-Subnet"
  }
}

# Create a Security Group
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-SG"
  }
}

# Create an EC2 Instance
resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type         = var.instance_type
  subnet_id             = aws_subnet.main.id          # Reference the subnet created
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]  # Reference the security group created

  tags = {
    Name = var.instance_name
  }
}

# Outputs
output "instance_id" {
  value = aws_instance.this.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "security_group_id" {
  value = aws_security_group.allow_ssh.id
}
