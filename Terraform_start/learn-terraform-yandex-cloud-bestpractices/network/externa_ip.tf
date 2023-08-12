# файл для определения статических ip

resource "yandex_vpc_address" "pablic_addr" {
  for_each = {
    for external_ips_array in local.external_ips_array : "${external_ips_array.name}" => external_ips_array #очень важный момент который раскрывает ситаксис этого цикла, "начиная с некого (неавжно как назовем v или external_ips_array в преременной local.external_ips_array имя записывать в некое (не важно v или external_ips_array)"
  }
  name = each.value.name
  external_ipv4_address {
    zone_id = each.value.zone
  }
}