# это файл в котором описывается сеть, а так же группы безопасности 

resource "yandex_vpc_network" "mynet" { #создание сети
  name = var.network_name
}
#в созданной сети описывается 3 подсети. Терраформ видит зависимости друг друга и создает их в нужной последовательности (ниже описано как это с сетью и подсетью). По возможности ресурсы создаются одновременно и только если есть четко указанная зависимость, он будет создавать что то последовательно
resource "yandex_vpc_subnet" "mysubnet-a" { #подсеть 
  v4_cidr_blocks = ["10.5.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.mynet.id #терраформ видит что для подсети нужна сеть, она указана в пути, по этому сначала создастся сеть, а потом подсеть
}

resource "yandex_vpc_subnet" "mysubnet-b" { #подсеть 
  v4_cidr_blocks = ["10.6.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.mynet.id
}

resource "yandex_vpc_subnet" "mysubnet-c" { #подсеть 
  v4_cidr_blocks = ["10.7.0.0/16"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.mynet.id
}

