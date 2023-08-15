# Здесь присваиваем значения объявленным переменным из файла variables.tf


#==================== main ====================
cloud_id = "b1gm3hna85fgcv7mif87"

folder_id = "b1gll7vtke087ibf3i59"

# default_zone = #указывать не будем, тк как есть дефолтное, но если что его можно здесь переопределить. Она так же доступна (с деф знач.) для исп в других файлах как и остальные переменные


#==================== terraform_remote_state ====================

network_state_key = "best-practice-k8s.tfstate"

network_backet_name = "for-terraform-tfstate"


#==================== service_account ====================
service_account_name = "myaccount"

kms_provider_key_name = "kms-key"


#==================== cluster ====================
cluster_name = "k8s_cluster"

# network_policy_provider = "" задано дефолтным значением

master_version = "1.27"

# master_publick_ip = "" задно дефолтным значением

master_region = "ru-central1"


#==================== node_groups ====================

node_groups = {
  node_group-a = {
    platform_id    = "standard-v1",
    name           = "worker-a-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-a",
    auto_scale = {
      min     = 1,
      max     = 3,
      initial = 1
    }
  }
  node_group-b = {
    platform_id    = "standard-v1",
    name           = "worker-b-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-b",
    fixed_scale = { #Только у первой группы auto_scale у остальных fixed, это для того, чтобы добавить возможность менять тип групп через переменные
      size = 1
    }
  }
  node_group-c = {
    platform_id    = "standard-v1",
    name           = "worker-c-{instance.short_id}",
    cores          = 2,
    memory         = 2,
    boot_disk_type = "network-ssd",
    boot_disk_size = 32,
    zone           = "ru-central1-c",
    fixed_scale = {
      size = 1
    }
  }
}
#в файле node_group.tf необходимо указать id подсетей, есть ранее созданный
#output который передает и зону и id. Его переделывать только на выдачу id 
#нельзя, потому что пропадет привязка к зоне.
#По этому сделаем преобразование данных через locals
