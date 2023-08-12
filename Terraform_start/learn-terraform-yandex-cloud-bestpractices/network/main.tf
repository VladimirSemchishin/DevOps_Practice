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
  service_account_key_file = "key.json"
  cloud_id                 = "b1gm3hna85fgcv7mif87"
  folder_id                = "b1gll7vtke087ibf3i59"
  zone                     = "ru-central1-a"
}