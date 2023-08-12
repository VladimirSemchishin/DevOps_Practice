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

#Создание регионального кластера K8s

locals { #сюда записываются не переопределяемые значения, которые множество раз исп. в конфигурации. Обычно его так не исп, как указано, потом исправим.
  cloud_id    = "b1gm3hna85fgcv7mif87"
  folder_id   = "b1gll7vtke087ibf3i59"
  k8s_version = "1.27"
  sa_name     = "myaccount"
}



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
    from_port      = 30000
    to_port        = 32767
  }
  egress {
    protocol       = "ANY"
    description    = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}


resource "yandex_iam_service_account" "myaccount" { #создание сервесного аккаунта и назначение ролей необходимых для работы кластера. Можно не создавать несколько сервисных акк, но безопаснее если на каждом сервисе будет свой.
  name        = local.sa_name                       #обращение к блоку local
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" { #назначение роли
  # Сервисному аккаунту назначается роль "editor".
  folder_id = local.folder_id #обращение к блоку local
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" { #назначение роли
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = local.folder_id #обращение к блоку local
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}




resource "yandex_kms_symmetric_key" "kms-key" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_resourcemanager_folder_iam_member" "viewer" {
  folder_id = local.folder_id #обращение к блоку local
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}




resource "yandex_kubernetes_cluster" "k8s-regional" { #создание ресурса кубрнетес кластер
  network_id              = yandex_vpc_network.mynet.id
  network_policy_provider = "CALICO" # контроллер для управления сетевыми политиками, установив занчение CALITO
  master {
    version   = local.k8s_version #обращение к блоку local
    public_ip = true              #даем кластеру внешний ip адресс
    regional {                    #для кластера требуется задействовать 3 подсети, в каждой из зон доступности
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.mysubnet-a.zone
        subnet_id = yandex_vpc_subnet.mysubnet-a.id
      }
      location {
        zone      = yandex_vpc_subnet.mysubnet-b.zone
        subnet_id = yandex_vpc_subnet.mysubnet-b.id
      }
      location {
        zone      = yandex_vpc_subnet.mysubnet-c.zone
        subnet_id = yandex_vpc_subnet.mysubnet-c.id
      }
    }
    security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
  }
  service_account_id      = yandex_iam_service_account.myaccount.id #сервисный аккаунт для кластера 
  node_service_account_id = yandex_iam_service_account.myaccount.id #сервисный аккаунт для воркера
  depends_on = [                                                    # механизм терраформа который позволяет указать последовательность задания ресурсов, а именно он задаст все эти права нашему сервисному аккаунту, потому что зависимость в данном случае привычным способом не указать.
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}