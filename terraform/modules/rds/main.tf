resource "aws_db_subnet_group" "this" {
  name       = "notes-db-subnet"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id
  name   = "rds-sg"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # only internal VPC
  }
}

resource "aws_db_instance" "this" {
  identifier              = "notesdb"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "postgres"
  password                = "Postgres123!"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
}

output "db_endpoint" {
  value = aws_db_instance.this.address
}

