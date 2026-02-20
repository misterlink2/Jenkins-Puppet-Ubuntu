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
