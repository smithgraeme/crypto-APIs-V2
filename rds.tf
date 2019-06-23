provider "aws" {
  version = "~> 2.14"
  region     = "us-east-1"
}

terraform {
  backend "remote" {
    organization = "graemeDev"

    workspaces {
      prefix = "Crypto-API-"
    }
  }
}

variable "db_password" {}

resource "aws_db_instance" "crypto-API-V2-RDS-DB" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "cryptoAPIV2${terraform.workspace}"
  username             = "admin"
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.db_all_access.id]
  publicly_accessible = true
  skip_final_snapshot = true
  final_snapshot_identifier = "finalSnapshot"
}

output "dbEndpoint" {
  value = aws_db_instance.crypto-API-V2-RDS-DB.endpoint
}

output "dbUsername" {
  value = aws_db_instance.crypto-API-V2-RDS-DB.username
}

resource "aws_security_group" "db_all_access" {
  name        = "db_all_access"
  description = "DB access from ANYWHERE. This should be locked down if actually using this."

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
