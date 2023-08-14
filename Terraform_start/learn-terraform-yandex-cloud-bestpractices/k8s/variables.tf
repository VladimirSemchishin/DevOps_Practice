# Это файл с параметрами (переменными), они здесь объявляются
#укажем что хотим создать 4 переменных

#==================== main ====================
variable "cloud_id" {
  description = "cloud id"
  type        = string
}
variable "folder_id" {
  description = "folder id"
  type        = string
}
variable "default_zone" {
  description = "default zone"
  type        = string
  default     = "ru-central1-a"
}

#==================== terraform_remote_state ====================
variable "network_state_key" {
  description = "The key of state for the network"
  type = string
  default = "null"
}

variable "network_backet_name" {
  description = "The name of bucket for the network"
  type = string
  default = "null"
}


#==================== service_account ====================
 variable "service_account_name" {      #ранее имя было задано через locals, теперь здаем его через перменную
   description = "Name of service account"
   type = string
   default = "null"
 }

variable "kms_provider_key_name" {    #еще чтобы передать ключ шифрования нужна переменная и для него
  description = "KMS key name"
  type = string
  default = "null"
}

#==================== cluster ====================
variable "cluster_name" {
  description = "Name of a specific Kubernetes cluster"
  type = string
  default = "null"
}

variable "network_policy_provider" {
  description = ""
  type = string
  default = "CALICO"
}

variable "master_version" {
  description = "Version of Kubernetes that will be used for master."
  type = string
  default = "null"
}

variable "master_publick_ip" {
  description = "Boolean flag. When true, Kubernetes master will have a visible ipv4 address."
  type = string
  default = "true"
}

variable "master_region" {
  description = "Name of region where cluster will be created. Required for regional cluster, not used for zonal cluster."
  type = string
  default = "null"
}