terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex" #глобальный адрес источника провайдера
    }
  }
  required_version = ">=0.13" #min версия Terraform, с которой совместим провайдер
}

provider "yandex" {                          #название провайдера   
  service_account_key_file = "key.json"      #путь к файлу учетной записи службы
  cloud_id                 = local.cloud_id  #id облака
  folder_id                = local.folder_id #id папки
  zone                     = "ru-central1-a" #зона доступности, в ней по умолч. будут создаваться ресурсы
}

locals {                             #объявляю локальные переменные
  cloud_id  = "b1gm3hna85fgcv7mif87" #id облака
  folder_id = "b1gll7vtke087ibf3i59" #id папки

  service-account = "catgpt-sa" #функция преобразует 

  catgpt-sa-roles = toset([
    "container-registry.images.puller",
    "monitoring.editor",
  ])
}

resource "yandex_vpc_network" "foo" { #описание сети
  name        = "network-foo"
  description = "Это сеть которую я создаю в файле main.tf запуском при помощи Terraform"
  labels = {
    owner   = "Vladimir Semchishin"
    project = "YY-workout"
  }
}

resource "yandex_vpc_subnet" "foo" { #описание подсети
  name           = "subnetwork-foo"
  description    = "Это подсеть сети network-foo которую я создал из файла main.tf"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id #id через дефолтную переменную описанной сети выше
}

resource "yandex_container_registry" "registry1" {
  name = "registry1"
}

resource "yandex_iam_service_account" "service-accounts" { #объявление сервисного аккаунта (IAM)
  name        = "${local.folder_id}-${local.service-account}"
  description = "созданный сервисный аккаунт: ${local.folder_id}-${local.service-account} через main.tf"
}

resource "yandex_resourcemanager_folder_iam_member" "catgpt-roles" { #описание ресурса, который помогает управлять политикой IAM. 
                                                                     #Это один из 3 - не авторитетный и дает характеристики только объявленным аккаунтам
  for_each  = local.catgpt-sa-roles
  folder_id = local.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.service-accounts.id}" #привязка к акаунту по id
}

data "yandex_compute_image" "coi" {
  family = "container-optimized-image"
}
resource "yandex_compute_instance" "catgpt-1" {
  name               = "vm-for-catgpt"
  platform_id        = "standard-v2"
  service_account_id = yandex_iam_service_account.service-accounts.id

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5 #производительность ядра в %
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.foo.id
  }


  metadata = {
    docker-compose = file("./docker-compose.yaml") #file - функ-я ссчитывающая содержимое файла расположенному по заданному пути и возвращает его в виде строки 
    ssh-keys       = "ubuntu:${file("~/.ssh/devops_training.pub")}"
  }
}