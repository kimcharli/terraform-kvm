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


resource "libvirt_volume" "centos-base" {
  provider = libvirt.server2
  name   = "centos-base"
  pool   = "images"
  source = "file:///home/contrail/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}


module "myvms" {
  source = "./libvirt-vm"
  vms = var.vms

  providers = {
    libvirt = libvirt.server2
  }

  base_image_id = libvirt_volume.centos-base.id
}
