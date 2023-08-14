resource "yandex_kubernetes_cluster" "k8s-regional" { #создание ресурса кубрнетес кластер
  #network_id              = data.yandex_vpc_network.network.name.id # здесь я ссылаюсь на внешний источник, так можно сделать, потому что сначала он был определен через data.tf как внешний источник
  #network_id = data.terraform_remote_state.network.outputs.network_id #так можно обратиться на прямую к файлу состоянию, в котором найдется output с id сети
  network_id = local.network_output.network_id # так можно упростить жизнь если создать еще local переменную которая будет ссылаться на data, что через нее был доступ к output (это проще если это выкупить, если не выкупать то такое себе упрощение)
  network_policy_provider = var.network_policy_provider # контроллер для управления сетевыми политиками, установив занчение CALITO
  service_account_id =      yandex_iam_service_account.myaccount.id #сервисный аккаунт для кластера просто перенес (раньше был полсе описания мастера)
  node_service_account_id = yandex_iam_service_account.myaccount.id #сервисный аккаунт для воркера просто перенес (раньше был полсе описания мастера)
  master {
    #version   = local.k8s_version #обращение к блоку local, чтобы указать версию мастер ноды
    version = var.master_version  #заменяем на созданную переменную указывающую версию мастера
    public_ip = var.master_publick_ip              #даем кластеру внешний ip адресс
    regional {                    #для кластера требуется задействовать 3 подсети, в каждой из зон доступности
      region = var.master_region
      /* #перепишем этот блок с учетом, что уже прописаны output с условием (в виде списка)
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
      */
      dynamic "location" {
        for_each = local.network_output.k8s_master_subnet_info
        content {
          zone = location.value["zone"]
          sybnet_id = location.value["subnet_id"]
        }
      }

    }
    #security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    security_group_ids = [local.network_output.sg_internal, local.network_output.sg_k8s_master]  
  }
  
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }

  depends_on = [                                                    # механизм терраформа который позволяет указать последовательность задания ресурсов, а именно он задаст все эти права нашему сервисному аккаунту, потому что зависимость в данном случае привычным способом не указать.
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
  
}



