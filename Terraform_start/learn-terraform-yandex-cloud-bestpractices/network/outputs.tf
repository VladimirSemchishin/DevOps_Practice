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


#==================== zone and id_subnetwork ====================
#здесь просто так вывести значение не получится, тк зона и id 
#подсети задаются циклом, по этому необходимо прописать условие

output "k8s_master_subnet_info" {
  value = [for k, v in var.subnets["k8s_masters"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.mysubnet-main[v.name].id, yandex_vpc_subnet.mysubnet-main[v.name].zone])]
}

output "k8s_worker_subnet_info" {
  value = [for k, v in var.subnets["k8s_worker"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.mysubnet-main[v.name].id, yandex_vpc_subnet.mysubnet-main[v.name].zone])]
}