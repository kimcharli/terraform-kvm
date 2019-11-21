
// create volume from base image
resource "libvirt_volume" "my-volume" {
  count = length(var.vms)
  name           = "${var.vms[count.index].name}-volume"
  base_volume_id = var.base_image_id
  pool           = "images"
  size           = var.vms[count.index].disk_mb
}

resource "libvirt_cloudinit_disk" "my-cloud-init" {
  count = length(var.vms)
  name      = "${var.vms[count.index].name}-init.iso"
  pool   = "images"
  user_data = templatefile("${path.module}/${var.vms[count.index].user_data_template}",var.vms[count.index])
  network_config = templatefile("${path.module}/network_config.tpl",var.vms[count.index])
}



// set boot order hd, network
resource "libvirt_domain" "myvm" {
  count = length(var.vms)
  name   = var.vms[count.index].name
  memory = var.vms[count.index].mem_mb
  vcpu   = var.vms[count.index].vcpu

  network_interface {
    bridge = var.vms[count.index].bridge1
    mac    = var.vms[count.index].mac1
  }

//  boot_device {
//    dev = ["hd", "network"]
//  }

  cloudinit = libvirt_cloudinit_disk.my-cloud-init[count.index].id

  disk {
    volume_id = libvirt_volume.my-volume[count.index].id
  }

  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type = "pty"
    target_type = "virtio"
    target_port = "1"
  }

//  graphics {
//    type        = "vnc"
//    listen_type = "address"
//  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}


