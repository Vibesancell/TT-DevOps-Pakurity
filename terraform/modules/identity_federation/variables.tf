variable "project" {
  type        = string
  description = "The project name"
}

variable "repo_owner" {
  type        = string
  description = "Name repo owner"
}

variable "account_id" {
  type        = string
  description = "Name account id"
}

variable "display_name" {
  type        = string
  description = "Name display name"
}

variable "description" {
  type        = string
  description = "Description application"
}

variable "roles" {
  type        = list(string)
  description = "List roles"
}