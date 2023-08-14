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
