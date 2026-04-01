variable "public_key" {
  description = "Cle SSH publique pour EC2"
  type        = string
}

variable "db_password" {
  type        = string
  description = "mot de passe RDS"
}