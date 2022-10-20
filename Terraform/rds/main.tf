# Create a rds MySQL 5.7 instance

resource "aws_db_instance" "rds_instance" {
  name = "ourdatabase"

  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"

  publicly_accessible = true

  username = var.dbuser
  password = var.dbpassword

# for auto scalling
  allocated_storage = 10
  max_allocated_storage = 50

 # If needed, we can delete our RDS instance with Terraform.
  skip_final_snapshot = true 

  tags = {
    n = "foo"
  }
}