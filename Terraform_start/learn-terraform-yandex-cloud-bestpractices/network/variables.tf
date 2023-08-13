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

#==================== network ====================
variable "network_name" {
  description = "name of main network"
  type        = string
}

#==================== subnets ====================
#опишем не одну переменную, а набор для подсетей, подойдет тип map
variable "subnets" {
  description = "Subnet for k8s"

  type = map(list(object(
    {
      name = string
      zone = string
      cidr = list(string)
    }
  )))

  validation { #здесь проверяется значения параметра j.zone в переменной var.subnets
    condition     = alltrue([for i in keys(var.subnets) : alltrue([for j in lookup(var.subnets, i) : contains(["ru-central1-a", "ru-central1-b", "ru-central1-c"], j.zone)])])
    error_message = "Error! Zones not supported!"
  }
}

#==================== external-static_ip ====================
variable "external_static_ips" { #переменная для определения статических ip, делается по аналогии с подсетями
  description = "static ips"

  type = map(list(object({
    name = string
    zone = string
  })))
}

#==================== security_group ====================
variable "white_ips_for_master" { #переменная из security_group.tf
  type = list(string)
}

