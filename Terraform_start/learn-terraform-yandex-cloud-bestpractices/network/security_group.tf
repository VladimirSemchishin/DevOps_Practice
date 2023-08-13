# Файл в который отдельно вынесены группы безопасности

/*
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
*/

#Создадим для мастера и для воркера разные группы правил

resource "yandex_vpc_security_group" "internal" { #эта группа существует для связоности мастеров и воркеров
  name        = "internal"
  description = "Meneged by terraform."
  network_id  = yandex_vpc_network.network-main.id

  labels = {
    firewall = "yc_internal"
  }

  ingress {
    protocol          = "ANY"
    description       = "self"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  egress {
    protocol          = "ANY"
    description       = "self"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s_master" { #эта группа существует для мастеров 
  name        = "k8_master"
  description = "Meneged by terraform."
  network_id  = yandex_vpc_network.network-main.id

  labels = {
    firewall = "k8_master"
  }

  ingress { # для передачи white листов
    protocol       = "TCP"
    description    = "access to api k8s"
    v4_cidr_blocks = var.white_ips_for_master #обращаемся к переменной которую позже создадим
    port           = 443
  }
  egress {
    protocol          = "TCP"
    description       = "access to api k8s from Yandex lb"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s_worker" { #эта группа существует для воркеров (где разрешено вообще все)
  name        = "k8_worker"
  description = "Meneged by terraform."
  network_id  = yandex_vpc_network.network-main.id
  labels = {
    firewall = "k8_worker"
  }

  ingress {
    protocol       = "ANY"
    description    = "any connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  egress {
    protocol       = "ANY"
    description    = "any connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}