
resource "libvirt_volume" "my-volume" {
  name           = "${var.myvm.name}-volume"
  base_volume_id = var.base_image_id
  pool           = "images"
  size           = var.myvm.disk_mb
}


data "template_file" "user-data-template" {
  template = file("${path.module}/../cloud_init_resize.cfg")
}


data template_file "network-config-template" {
  template = file("${path.module}/../network_config.tpl")
  vars = {
    myip = var.myvm.ip1
    mysubnet = var.myvm.subnet1
  }
}

resource "libvirt_cloudinit_disk" "my-cloud-init" {
  name      = "${var.myvm.name}-init.iso"
  pool   = "images"
  user_data = data.template_file.user-data-template.rendered
  network_config = data.template_file.network-config-template.rendered
}



// set boot order hd, network
resource "libvirt_domain" "myvm" {
  name   = var.myvm.name
  memory = var.myvm.mem_mb
  vcpu   = var.myvm.vcpu

  network_interface {
    bridge = var.myvm.bridge1
    mac    = var.myvm.mac1
  }

//  boot_device {
//    dev = ["hd", "network"]
//  }

  cloudinit = libvirt_cloudinit_disk.my-cloud-init.id

  disk {
    volume_id = libvirt_volume.my-volume.id
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


