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