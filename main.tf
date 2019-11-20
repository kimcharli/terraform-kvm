//////// main

terraform {
  required_version = ">= 0.12"
}

provider "libvirt" {
    uri = "qemu:///system"
}

//ssh-copy-id server3.pslab.net
//sudo usermod -aG libvirt contrail


provider "libvirt" {
  alias = "server2"
  uri   = "qemu+ssh://contrail@server2.pslab.net/system"
}

provider "libvirt" {
  alias = "server3"
  uri   = "qemu+ssh://contrail@server3.pslab.net/system"
}

provider "libvirt" {
  alias = "server7"
  uri   = "qemu+ssh://contrail@server7.pslab.net/system"
}

//resource "libvirt_domain" "terraform_test" {
//  name = "terraform_test"
//}




// blank 10GB image for net install.
resource "libvirt_volume" "centos-base" {
  provider = libvirt.server2
  name   = "centos-base"
  pool   = "images"
  source = "file:///home/contrail/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}



//resource "libvirt_volume" "centos-1" {
//  name           = "centos-1-disk-resized"
//  base_volume_id = libvirt_volume.centos-base.id
//  pool           = "images"
//  size           = 100361393152
//}

//resource "libvirt_volume" "centos-2" {
//  name           = "centos-2-disk-resized"
//  base_volume_id = libvirt_volume.centos-base.id
//  pool           = "images"
//  size           = var.vms[1].disk_mb
//}


data "template_file" "user_data_resize" {
  template = file("${path.module}/cloud_init_resize.cfg")
}

//resource "libvirt_cloudinit_disk" "centos-1" {
//  provider = libvirt.server2
//  name      = "centos1-init.iso"
//  user_data = data.template_file.user_data_resize.rendered
//  pool   = "images"
////  pool   = "default"
//  network_config = file("${path.module}/centos1-network_config")
//}

//resource "libvirt_cloudinit_disk" "centos-2" {
//  provider = libvirt.server2
//  name      = "centos2-init.iso"
//  user_data = data.template_file.user_data_resize.rendered
//  pool   = "images"
////  pool   = "default"
//  network_config = file("${path.module}/centos2-network_config")
//}


//// set boot order hd, network
//resource "libvirt_domain" "centos-1" {
//  provider = libvirt.server2
//  name   = "centos-1"
//  memory = "1024"
//  vcpu   = 1
//
//  network_interface {
//    bridge = "brc0"
//    mac    = "02:00:0a:04:05:80"
//  }
//
////  boot_device {
////    dev = ["hd", "network"]
////  }
//
//  cloudinit = libvirt_cloudinit_disk.centos-1.id
//
//  disk {
//    volume_id = libvirt_volume.centos-1.id
//  }
//
//  console {
//    type = "pty"
//    target_port = "0"
//    target_type = "serial"
//  }
//
//  console {
//    type = "pty"
//    target_type = "virtio"
//    target_port = "1"
//  }
//
////  graphics {
////    type        = "vnc"
////    listen_type = "address"
////  }
//
//  graphics {
//    type        = "spice"
//    listen_type = "address"
//    autoport    = true
//  }
//}


//// set boot order hd, network
//resource "libvirt_domain" "centos-2" {
//  provider = libvirt.server2
//  name   = var.vms[1].name
//  memory = var.vms[1].mem_mb
//  vcpu   = var.vms[1].vcpu
//
//  network_interface {
//    bridge = var.vms[1].bridge1
//    mac    = var.vms[1].mac1
//  }
//
////  boot_device {
////    dev = ["hd", "network"]
////  }
//
//  cloudinit = libvirt_cloudinit_disk.centos-2.id
//
//  disk {
//    volume_id = libvirt_volume.centos-2.id
//  }
//
//  console {
//    type = "pty"
//    target_port = "0"
//    target_type = "serial"
//  }
//
//  console {
//    type = "pty"
//    target_type = "virtio"
//    target_port = "1"
//  }
//
////  graphics {
////    type        = "vnc"
////    listen_type = "address"
////  }
//
//  graphics {
//    type        = "spice"
//    listen_type = "address"
//    autoport    = true
//  }
//}

//
//resource "libvirt_network" "tf" {
//  name      = "tf"
//  domain    = "tf.local"
//  mode      = "nat"
//  addresses = ["10.0.100.0/24"]
//}

//output "ip" {
//  value = libvirt_domain.centos-terra-1.
//}


module "myvm1" {
  source = "./libvirt-vm"
  myvm = var.vms[0]

  providers = {
    libvirt = libvirt.server2
  }

  base_image_id = libvirt_volume.centos-base.id

}


module "myvm2" {
  source = "./libvirt-vm"
  myvm = var.vms[1]

  providers = {
    libvirt = libvirt.server2
  }

  base_image_id = libvirt_volume.centos-base.id

}

module "libvirt-vm" {
  source = "./libvirt-vm"
  myvm = var.vms[2]

  providers = {
    libvirt = libvirt.server2
  }

  base_image_id = libvirt_volume.centos-base.id

}
