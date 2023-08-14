resource "yandex_iam_service_account" "myaccount" { #создание сервесного аккаунта и назначение ролей необходимых для работы кластера. Можно не создавать несколько сервисных акк, но безопаснее если на каждом сервисе будет свой.
  name        = local.sa_name                       #обращение к блоку local
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" { #назначение роли 
  # Сервисному аккаунту назначается роль "editor".
  folder_id = local.folder_id #обращение к блоку local
  role      = "editor"
  members = [ #пользователь которому будет присвоена роль
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" { #назначение роли
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = local.folder_id #обращение к блоку local
  role      = "container-registry.images.puller"
  members = [ #пользователь которому будет присвоена роль
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}


resource "yandex_kms_symmetric_key" "kms-key" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_resourcemanager_folder_iam_binding" "viewer" {
  folder_id = local.folder_id #обращение к блоку local
  role      = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}