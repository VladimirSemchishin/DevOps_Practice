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