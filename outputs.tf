output "vpc_id" {
  description = "ID DU VPC"
  value       = aws_vpc.main.id
}

output "subnet_public_id" {
  description = "ID du subnet public"
  value       = aws_subnet.public.id
}

output "subnet_private_id" {
  description = "ID du subnet prive"
  value       = aws_subnet.private.id
}

output "sg_public_id" {
  description = "ID du Security Group public"
  value       = aws_security_group.public.id
}

output "sg_private_id" {
  description = "ID du Security Group prive"
  value       = aws_security_group.private.id
}   


output "rds_endpoint" {
  description = "Endpoint RDS PostgreSQL"
  value       = aws_db_instance.main.endpoint
  sensitive   = false
}