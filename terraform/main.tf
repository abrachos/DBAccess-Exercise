terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"  # Puedes cambiar la versión según tus necesidades
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-00cae169b96dabf0d"
  instance_type = "t2.micro"

  tags = {
    Name = "web-instance_VirtualAccount"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.15"
  instance_class       = "db.m5d.large"
  identifier           = "clientes-db"
  username             = "postgres"
  password             = "postgres"
  db_subnet_group_name = "virtualaccount_subnet"
  skip_final_snapshot  = true

  tags = {
    Name = "database-instance"
  }
}
