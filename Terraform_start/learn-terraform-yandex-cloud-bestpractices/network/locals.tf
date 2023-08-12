/*описываем одноименную переменную subnet_array, но не как ранее было в общем main, 
а по условию "берет список и заменяет любые элементы, которые являются списками, плоской последовательностью содержимого списка."
или если не из документации "перебирает значения из пременной var.subnets и подставляет их в локальные переменные subnet_array в виде списка"
*/
locals {
  subnet_array = flatten([for k, v in var.subnets : [for j in v : {
    name = j.name
    zone = j.zone
    cidr = j.cidr
  }]])


  external_ips_array = flatten([for k, v in var.external_static_ips : [for j in v : {
    name = j.name
    zone = j.zone
  }]])
}