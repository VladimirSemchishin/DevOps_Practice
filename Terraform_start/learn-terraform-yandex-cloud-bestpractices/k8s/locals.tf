locals {
  network_output = data.terraform_remote_state.network.outputs #теперь если к примеру нужно исп. id сети : local.network_output.network_id
}