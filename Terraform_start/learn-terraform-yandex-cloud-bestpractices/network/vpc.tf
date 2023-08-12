# это файл в котором описывается сеть, а так же группы безопасности 

resource "yandex_vpc_network" "mynet" { #создание сети
  name = "mynet"
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

resource "yandex_vpc_security_group" "k8s-main-sg" { #создание группы безопасности
  name        = "k8s-main-sg"
  description = "Правила группы обеспечивают базовую работоспособность кластера Managed Service for Kubernetes. Примените ее к кластеру Managed Service for Kubernetes и группам узлов."
  network_id  = yandex_vpc_network.mynet.id
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol       = "ANY"
    description    = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
    v4_cidr_blocks = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
    from_port      = 0
    to_port        = 65535
  }
  ingress {
    protocol       = "ICMP"
    description    = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks = ["0.0.0.0/0"]
    port      = 443
  }
  egress {
    protocol       = "ANY"
    description    = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}