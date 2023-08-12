#здесь вставлены блоки кода описывающие инициализацию в облаке и подключение провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoint                = "storage.yandexcloud.net"
    bucket                  = "for-terraform-tfstate"
    region                  = "ru-central1"
    key                     = "best-practice-network.tfstate" #изменить имя файла состояния, тк файл о подключение к сети 
    shared_credentials_file = "storage.key"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = "key.json" #задаваьб переменными нужно там, где значение будет меняться, файл с логином и поролем меняться не будет. 
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}