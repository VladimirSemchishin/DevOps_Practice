# файл для определения статических ip

resource "yandex_vpc_address" "pablic_addr" {
  for_each = {
    for v in local.external_ips_array : "${v.name}" => v
  }
  name = each.value.name
  external_ipv4_address {
    zone_id = each.value.zone
  }
}