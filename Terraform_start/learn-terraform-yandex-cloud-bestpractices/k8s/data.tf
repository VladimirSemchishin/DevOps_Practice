#чтобы взять данные извне (в данном случае нужны id сети которые поднимались в манифесте файла network)
#Блок dataзапрашивает, чтобы Terraform читал из заданного источника данных («yandex_vpc_network») и экспортировал результат под заданным локальным именем («network»). Имя используется для ссылки на этот ресурс из другого места в том же модуле Terraform, но не имеет никакого значения за рамками модуля.
data "yandex_vpc_network" "network" { 
  name = "mynet" #ресурс = значение, это фильтр по которому достанется из yandex_vpc_network только имя. Оно так же описано и там откуда берется
                 #только в директории network в terraform.tfvars нет такого определения, есть network_name = "mynet" если будет ошибка, то нужно будет заменить 
}

#Если имя сети поменяется при дальнейшей работе, то его в любом случае придется переписывать в этом файле или если вынести как переменную
#Чтобы всегда ссылаться на правильный id сети, вне зависимости от ее имени, будем ссылаться на tfstate файл (тот который в s3)
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    endpoint = "storage.yandexcloud.net"
    bucket = var.network_backet_name
    region = "ru-central1"
    key = var.network_state_key
    shared_credentials_file = "storage.key"

    skip_region_validation = true
    skip_credentials_validation = true
  }
}