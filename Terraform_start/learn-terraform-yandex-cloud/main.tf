terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "for-terraform-tfstate"
    region   = "ru-central1"
    key      = "terraform-yndex-vm1.tfstate"
    #shared_credentials_file = "/home/smvn/Desktop/Github/DevOps_Practice/Terraform_start/learn-terraform-yandex-cloud/storage.key" #передать идентификатор и секретный ключ, но не напрямую в коде, потому что это тупо, а через файл, потому что это умно.
    access_key = "YCAJE30R9niv6yiKsQdaSMudc"
    secret_key = "YCPCGxkBtcUNYY0LOnBAUlr3xooVB4vxPukRWnW6"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

// Configure the Yandex.Cloud provider
provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = "b1gm3hna85fgcv7mif87"
  folder_id                = "b1gll7vtke087ibf3i59"
  zone                     = "ru-central1-a"
}

resource "yandex_vpc_network" "practice-vpc" { #создаем ресурс yandex_vpc_network то как оно пишется можно узнать только из документации, а затем даем ему имя practice-vpc
  name = "practice"                            #уникальный идентификатор ресурса будет yandex_vpc_network.practice-vpс а имя самой сети будет practice
}

resource "yandex_vpc_subnet" "practice-vpc-subnet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  network_id     = yandex_vpc_network.practice-vpc.id #на прямую (типо enpqs3mggbcvk7ibuqga) лучше не передавать идентификатор сети, к которой пренадлежит данная подсеть, yandex_vpc_network.practice-vpс тип ресурса и его назначение через точку - инд. идентиф. на который можно ссылаться как на переменную. Точка id (.id) указывает на то, какой параметр нужно передать.
}

resource "yandex_vpc_security_group" "sec-group-1" {
  name        = "security group for VM-1"
  description = "description for my security group"
  network_id  = yandex_vpc_network.practice-vpc.id

  labels = {
    my-label = "my-label-value"
  }

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      protocol       = "TCP"
      description    = "rule1 description"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = ingress.value
      to_port        = ingress.value
    }
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }


}

resource "yandex_vpc_address" "const-ip-vm1" { #для установки постоянного адреса ВМ-1
  name = "IpAddressVM1"

  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_compute_instance" "vm-1" {
  name        = "virtual-machine"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80eup4e4h7mmodr9d4" #чтобы узнать вбиваем в гугле, переходим в доку яндекс клуд и находим там команду которая покажет доступные образы в консоли: yc compute image list --folder-id standard-images | grep debian-11 (вторая чать значит что нужно искать дебиан 11), в выводе берем последнюю (просто самую верхнюю)
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.practice-vpc-subnet.id
    nat            = true
    nat_ip_address = yandex_vpc_address.const-ip-vm1.external_ipv4_address.0.address #параметр address (в принципе вся строка была написана) был указан после запуска команды terraform plan, в его выводе можно посмотерть вообще все что он меняет и не меняет в плане атрибутов, та же был и адресс (known after apply). Но их может быть несколько, по этому указываем что нужно взять первый элемент массива (.0.address)  
  }

  metadata = { #все что пишется в этом блоке выполнеяется только после инициации ВМ
    ssh-keys  = "debian:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("init.sh")}" #с помощью этого параметра можно передавать например скрипт на исполнение
  }
}

output "external_ip" { #первый вариант задать выходное значение через конечный идентификатор, который задается как значение переменной network_interface в блоке   network_interface
  value = yandex_vpc_address.const-ip-vm1.external_ipv4_address.0.address
}

output "external_ip2" { #в названии можно писать все что угодно, через output в терраформе указываются выходные данные. Тут должен быть тот же вывод что и в прошлои output но значение задается идентификатором переменной в которую клали занчение (  network_interface) то есть идентификатор nat_ip_address (похоже на путь)
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}


