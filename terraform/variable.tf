variable "key-name" {
    type = string
    default="firstpem"
}

variable "hosted-zone" {
    type = string
    default="erkanbaran.me"
}

variable "git-user" {
    type = string
    default="ErkanBarann"
}
variable "repo-name" {
    type = string
    default="car-rental-system-with-terraform"
}

variable "dbname" {
    type = string
    default="araba_kiralama"
}
variable "dbuser" {
    type = string
    default="admin"
}

variable "dbsifre" {
    type = string
    default="admin123" # Consider using a secret manager (e.g., AWS Secrets Manager, HashiCorp Vault) for sensitive data.
}
variable "app-name" {
    type = string
    default="araba-kiralama"
}
variable "domain-name" {
    type = string
    default="erkanbaran.me"
}


