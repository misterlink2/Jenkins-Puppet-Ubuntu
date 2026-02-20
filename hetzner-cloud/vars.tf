variable "location" {
  default = "hel1" # US: ash or hil | hel1 is Helsinki, which has cheap servers
}

variable "ssh_key_path" {
  type        = string
  description = "Path to the public SSH key file"
  default     = "~/.ssh/hetzer.pub"
}

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of IP addresses allowed to access the server"
  default     = ["206.55.186.141/32"]
}
