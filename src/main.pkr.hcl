source "proxmox" "golden-image" {
  boot_command             = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_pve.cfg<enter><wait>"]
  boot_wait                = "10s"
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  cores                    = 1
  cpu_type                 = "kvm64"
  http_directory           = "files/http"
  insecure_skip_tls_verify = true
  iso_checksum             = var.iso_checksum
  iso_storage_pool         = var.iso_storage_pool
  iso_url                  = var.iso_url
  memory                   = "1024"
  node                     = var.node
  os                       = "l26"
  password                 = var.password
  proxmox_url              = var.proxmox_url
  qemu_agent               = true
  sockets                  = 1
  ssh_password             = var.ssh_password
  ssh_timeout              = "30m"
  ssh_username             = var.ssh_username
  template_description     = "Template ${var.vm_name} generated on ${formatdate("EEEE MMMM D, YYYY", timestamp())} by Packer."
  template_name            = var.vm_name
  unmount_iso              = true
  username                 = var.username
  vm_name                  = var.vm_name

  disks {
    disk_size         = "25G"
    storage_pool      = var.storage_pool
    storage_pool_type = var.storage_pool_type
    type              = "virtio"
  }

  network_adapters {
    bridge = var.bridge
  }
}

build {
  sources = ["source.proxmox.golden-image"]

  provisioner "file" {
    content     = base64decode(var.id_rsa)
    destination = "/tmp/id_rsa"
  }

  provisioner "file" {
    content     = base64decode(var.id_rsa_pub)
    destination = "/tmp/id_rsa.pub"
  }

  provisioner "salt-masterless" {
    minion_config    = "files/salt/config/minion"
    local_state_tree = "files/salt/state"
    grains_file      = "files/salt/config/grains"
    salt_call_args   = "saltenv=base"
    skip_bootstrap   = true
  }
}
