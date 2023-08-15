locals {
  network_output     = data.terraform_remote_state.network.outputs                                                                                                                         #теперь если к примеру нужно исп. id сети : local.network_output.network_id
  worker_subnet_list = zipmap([for subnet in local.network_output.k8s_workers_subnet_info : subnet.zone], [for subnet in local.network_output.k8s_workers_subnet_info : subnet.subnet_id]) #преобразование данных через locals, создается список где каждой зоне присвоится id
}