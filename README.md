# terraform-kvm

provider in https://github.com/dmacvicar/terraform-provider-libvirt

from centos

setup terraform
```
curl https://releases.hashicorp.com/terraform/0.12.14/terraform_0.12.14_linux_amd64.zip -o /var/tmp/terraform_0.12.14_linux_amd64.zip

sudo unzip /var/tmp/terraform_0.12.14_linux_amd64.zip -d /usr/local/bin

[contrail@server2 ~]$ terraform version
Terraform v0.12.14
[contrail@server2 ~]$ 
```

setup go
```

curl https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz -o /var/tmp/go1.13.4.linux-amd64.tar.gz
sudo tar -zxf /var/tmp/go1.13.4.linux-amd64.tar.gz -C /usr/local/

[contrail@server2 ~]$ /usr/local/go/bin/go version
go version go1.13.4 linux/amd64
[contrail@server2 ~]$ 

~/.bash_profile

export GOPATH=$HOME/go
PATH=$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/go/bin

mkdir -p ~/go/{src,bin,pkg}

```


```

sudo yum install libvirt-devel


mkdir -p $GOPATH/src/github.com/dmacvicar; cd $GOPATH/src/github.com/dmacvicar
git clone https://github.com/dmacvicar/terraform-provider-libvirt.git

cd $GOPATH/src/github.com/dmacvicar/terraform-provider-libvirt
make install

[contrail@server2 terraform-provider-libvirt]$ ls $GOPATH/bin
terraform-provider-libvirt
[contrail@server2 terraform-provider-libvirt]$ 


mkdir -p $HOME/.terraform.d/plugins
cp $GOPATH/bin/terraform-provider-libvirt $HOME/.terraform.d/plugins

```



ssh-copy-id to the target hypervisors

add group libvirt on target hypervisors
sudo usermod -aG libivrt contrail




```bash
ckim-mbp:terraform-kvm ckim$ rsync -avz -e ssh ../terraform-kvm server2.pslab:

```

```
[contrail@server2 terraform-provider-libvirt]$ cd ~/terraform-kvm/
[contrail@server2 terraform-kvm]$ terraform init

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[contrail@server2 terraform-kvm]$ 


terraform plan
terraform apply


```


example

https://github.com/MalloZup/ceph-open-terrarium/blob/master/examples/libvirt/centos.tf


```
[contrail@server2 terraform-kvm]$ virsh -c qemu:///system list 
 Id    Name                           State
----------------------------------------------------
 3     centos-terra-1                 running

[contrail@server2 terraform-kvm]$ 
[contrail@server2 terraform-kvm]$ virsh -c qemu:///system console centos-terra-1 

```


    <type arch='x86_64' machine='pc-i440fx-rhel7.6.0'>hvm</type>
    <type arch='x86_64' machine='pc-i440fx-rhel7.6.0'>hvm</type>
 

```
[contrail@server2 terraform-kvm]$ virsh -c qemu:///system destroy  centos-terra-1 
Domain centos-terra-1 destroyed

[contrail@server2 terraform-kvm]$ virsh -c qemu:///system undefine  centos-terra-1 --remove-all-storage
Domain centos-terra-1 has been undefined
Volume 'vda'(centos-1) removed.
Volume 'hdd'(/var/lib/libvirt/images/centos1-init.iso) removed.

[contrail@server2 terraform-kvm]$ 

```

== TODO
- resize disk
- fix issue of pc-i440fx-rhel7.6.0
```
Error: [WARN] Cannot find machine type pc-i440fx-rhel7.6.0 for hvm/x86_64 in 
```


