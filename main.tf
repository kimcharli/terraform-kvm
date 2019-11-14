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
resource "libvirt_volume" "centos-1" {
  provider = libvirt.server2
  name   = "centos-1"
  pool   = "images"
//  pool   = "default"
//  format = "qcow2"
  source = "file:///home/contrail/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
//  size   = 100000000
}


data "template_file" "user_data_resize" {
  template = file("${path.module}/cloud_init_resize.cfg")
}

resource "libvirt_cloudinit_disk" "centos-1" {
  provider = libvirt.server2
  name      = "centos1-init.iso"
  user_data = data.template_file.user_data_resize.rendered
  pool   = "images"
//  pool   = "default"
  network_config = file("${path.module}/centos1-network_config")
}



// set boot order hd, network
resource "libvirt_domain" "centos-terra-1" {
  provider = libvirt.server2
  name   = "centos-terra-1"
  memory = "1024"
  vcpu   = 1

  network_interface {
    bridge = "brc0"
    mac    = "02:00:0a:04:05:80"
//    network_name = "tf"
  }

//  boot_device {
//    dev = ["hd", "network"]
//  }

  cloudinit = libvirt_cloudinit_disk.centos-1.id

  disk {
    volume_id = libvirt_volume.centos-1.id
//    file = "${path.module}/image.iso"
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

