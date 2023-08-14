resource "yandex_kubernetes_cluster" "k8s-regional" { #создание ресурса кубрнетес кластер
  network_id              = yandex_vpc_network.mynet.id
  network_policy_provider = "CALICO" # контроллер для управления сетевыми политиками, установив занчение CALITO
  master {
    version   = local.k8s_version #обращение к блоку local, чтобы указать версию мастер ноды
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
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}


