variable "policy_name" {
    type = string
    description = "Your policy name"
    default = "StopStartRebootRDS"
}

variable "default_description" {
    type = string
    description = "Your policy description"
    default = "Managed by Terraform"
}

variable "role_name" {
    type = string
    description = "Your role name"
    default = "StopStartRebootRDS"
}

variable "databases" {
    type = list(string)
    description = "List of Databases to Stop/Start"
}

variable "apply_only_at_cron_interval" {
    type = bool
    default = true
}

variable "cron_stop" {
    type = string
    description = "Cron used to stop instances"
}

variable "cron_start" {
    type = string
    description = "Cron used to start instances"
}