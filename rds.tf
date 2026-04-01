resource "aws_db_subnet_group" "main" {
  name        = "db-subnet-group"
  description = "subnet group pour RDS PostgreSQL"
  subnet_ids  = [aws_subnet.private.id, aws_subnet.public.id]

  tags = {
    name      = "db-subnet-group"
    ManagedBy = "terraform"
  }
}

resource "aws_db_parameter_group" "postgres" {
  name        = "postgres-params"
  family      = "postgres15"
  description = "Parameter group pour PostgreSQL 15"
  tags = {
    Name      = "postgres-params"
    ManagedBy = "terraform"
  }
}
resource "aws_db_instance" "main" {
  identifier             = "phase1-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "phase1db"
  username               = "admindb"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.private.id]
  parameter_group_name   = aws_db_parameter_group.postgres.name
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name      = "phase1-db"
    ManagedBy = "terraform"
  }
}
