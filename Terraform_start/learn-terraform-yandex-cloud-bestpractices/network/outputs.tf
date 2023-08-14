#файл описывающий данные которые будут выводится
#После запуска terraform apply, данные запишутся 
#в файл состояния  и стобы сослаться на какой либо 
#ресурс из network потребуется постоянно указывать конструкцию 
#data.terraform_remote_state.network.outputs.[имя того output'a который нужен]

#==================== network ====================
output "network_id" {
  value = yandex_vpc_network.network-main.id
}

#==================== security_group ====================
output "sg_internal" {
  value = yandex_vpc_security_group.internal.id
}

output "sg_k8s_master" {
  value = yandex_vpc_security_group.k8s_master.id
}

output "sg_k8s_worker" {
  value = yandex_vpc_security_group.k8s_worker.id
}