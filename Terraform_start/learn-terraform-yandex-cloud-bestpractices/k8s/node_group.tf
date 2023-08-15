
#создание группы узлов в кластере k8s
#resource "yandex_kubernetes_node_group" "my_node_group_a" {
resource "yandex_kubernetes_node_group" "my_node_groups" { #меняем имя ресурса
  for_each    = var.node_groups
  cluster_id  = yandex_kubernetes_cluster.k8s-regional.id #ссылаемся на кластер k8s
  name        = each.key                                  #имя для всей группы (не одной вм)
  description = lookup(each.value, "description", null)
  #version     = local.k8s_version #указывают версию такую как у мастер ноды
  version = lookup(each.value, "version", var.master_version)
  labels  = lookup(each.value, "labels", null)

  instance_template {
    platform_id = lookup(each.value, "platform_id", null) #поставим 1 вместо 2 чтобы это не значило
    #name        = "worker-a-{instance.short_id}" #задается имя конкретного instace (вм). Поскольку включен futo_scaling ноды будут создаться автоматически, при повышении нагрузки, а так же уничтожаться. По этому фиксированное значение не подойдет. В соотв с докой сделаем через переменную уникальной. В данном случае отметим уникальный id в рамках группы и id группы
    name = lookup(each.value, "name", null)

    network_interface {
      nat                = lookup(each.value, "nat", true)
      subnet_ids         = [lookup(local.worker_subnet_list, each.value["zone"])]
      security_group_ids = [lookup(local.network_output.sg_internal, local.network_output.sg_k8s_worker)]
    }
    resources {
      memory = lookup(each.value, "memory", 2)
      cores  = lookup(each.value, "cores", 2)
    }
    boot_disk {
      type = lookup(each.value, "boot_disk_type", "network-hdd")
      size = lookup(each.value, "boot_disk_size", 32)
    }
    scheduling_policy {
      preemptible = lookup(each.value, "preemptible", false)
    }
  }

  scale_policy {
    dynamic "fixed_scale" {
      for_each = flatten([lookup(each.value, "fixed_scale", can(each.value["auto_scale"]) ? [] : [{ size = 1 }])])

      content {
        size = fixed_scale.value.size
      }
    }

    dynamic "auto_scale" {
      for_each = flatten([lookup(each.value, "auto_scale", [])])

      content {
        min     = auto_scale.value.min
        max     = auto_scale.value.max
        initial = auto_scale.value.initial
      }
    }
    #auto_scale {
    #  min     = 1
    #  max     = 4
    #  initial = 1
    #}
  }

  allocation_policy {
    location {
      #zone = "ru-central1-a"
      zone = each.value["zone"]
    }
  }

}


#Нет необходимости описывать каждую группу, потому что выше описаны все через обращение к значениям через цикл
/*
#создание группы узлов в кластере k8s
resource "yandex_kubernetes_node_group" "my_node_group_b" {
  cluster_id  = yandex_kubernetes_cluster.k8s-regional.id #ссылаемся на кластер k8s
  name        = "worker-b"                                #имя для всей группы (не одной вм)
  description = "description"
  version     = local.k8s_version #указывают версию такую как у мастер ноды

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v1"                                                            #поставим 1 вместо 2 чтобы это не значило
    name        = "worker-b-{instance.short_id}" #задается имя конкретного instace (вм). Поскольку включен futo_scaling ноды будут создаться автоматически, при повышении нагрузки, а так же уничтожаться. По этому фиксированное значение не подойдет. В соотв с докой сделаем через переменную уникальной. В данном случае отметим уникальный id в рамках группы и id группы

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.mysubnet-b.id] # указал верную существующую подстеть для группы b подсеть b
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id] # продублировал идентификаторы группы безопасности
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 32
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 4
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }
}

#создание группы узлов в кластере k8s
resource "yandex_kubernetes_node_group" "my_node_group_c" {
  cluster_id  = yandex_kubernetes_cluster.k8s-regional.id #ссылаемся на кластер k8s
  name        = "worker-c"                                #имя для всей группы (не одной вм)
  description = "description"
  version     = local.k8s_version #указывают версию такую как у мастер ноды

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v1"                                                            #поставим 1 вместо 2 чтобы это не значило
    name        = "worker-c-{instance.short_id}" #задается имя конкретного instace (вм). Поскольку включен futo_scaling ноды будут создаться автоматически, при повышении нагрузки, а так же уничтожаться. По этому фиксированное значение не подойдет. В соотв с докой сделаем через переменную уникальной. В данном случае отметим уникальный id в рамках группы и id группы

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.mysubnet-c.id] # указал верную существующую подстеть для группы c подсеть c
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id] # продублировал идентификаторы группы безопасности
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 32
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 4
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-c"
    }
  }
}
*/