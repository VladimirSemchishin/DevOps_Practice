# Здесь присваиваем значения объявленным переменным из файла variables.tf

cloud_id = "b1gm3hna85fgcv7mif87"

folder_id = "b1gll7vtke087ibf3i59"

# default_zone = #указывать не будем, тк как есть дефолтное, но если что его можно здесь переопределить. Она так же доступна (с деф знач.) для исп в других файлах как и остальные переменные

network_name = "mynet"

#определяем набор переменных
subnets = {
  "k8s_masters" = [ 
  {
    name = "k8s_master_zone_a"
    zone = "ru-central1-a"
    cidr = ["10.0.1.0/28"]
  },
  {
    name = "k8s_master_zone_a"
    zone = "ru-central1-b"
    cidr = ["10.0.2.0/28"]
  },
  {
    name = "k8s_master_zone_c"
    zone = "ru-central1-c"
    cidr = ["10.0.3.0/28"]
  }   
  ],
  "k8s_workers" = [ 
  {
    name = "k8s_master_zone_a"
    zone = "ru-central1-a"
    cidr = ["10.0.4.0/28"]
  },
  {
    name = "k8s_master_zone_b"
    zone = "ru-central1-b"
    cidr = ["10.0.5.0/28"]
  },
  {
    name = "k8s_master_zone_c"
    zone = "ru-central1-c"
    cidr = ["10.0.6.0/28"]
  }
  ]
}