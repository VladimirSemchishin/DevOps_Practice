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


