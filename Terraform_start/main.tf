terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

// Configure the Yandex.Cloud provider
provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = "b1gm3hna85fgcv7mif87"
  folder_id                = "b1gll7vtke087ibf3i59"
  zone                     = "ru-central1-a"
}

resource "yandex_vpc_network" "practice-vpc" { #создаем ресурс yandex_vpc_network то как оно пишется можно узнать только из документации, а затем даем ему имя practice-vpc
  name = "practice" #уникальный идентификатор ресурса будет yandex_vpc_network.practice-vpс а имя самой сети будет practice
}

resource "yandex_vpc_subnet" "practice-vpc-subnet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  network_id     = "${yandex_vpc_network.practice-vpc.id}" #на прямую (типо enpqs3mggbcvk7ibuqga) лучше не передавать идентификатор сети, к которой пренадлежит данная подсеть, yandex_vpc_network.practice-vpс тип ресурса и его назначение через точку - инд. идентиф. на который можно ссылаться как на переменную. Точка id (.id) указывает на то, какой параметр нужно передать.
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
    subnet_id = "${yandex_vpc_subnet.practice-vpc-subnet.id}"
    nat = true
  }

  metadata = {  #все что пишется в этом блоке выполнеяется только после инициации ВМ
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("init.sh")}" #с помощью этого параметра можно передавать например скрипт на исполнение
  }
}
