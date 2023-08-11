#Подключение к провайдеру и инициализация в облаке
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
    key                     = "best-practice.tfstate"
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





// Configure the Yandex.Cloud provider

