#файл описывающий данные которые будут выводится
#После запуска terraform apply, данные запишутся 
#в файл состояния  и стобы сослаться на какой либо 
#ресурс из network потребуется постоянно указывать конструкцию 
#data.terraform_remote_state.network.outputs.[имя того output'a который нужен]

output "network_id" {
  value = yandex_vpc_network.network-main.id
}
