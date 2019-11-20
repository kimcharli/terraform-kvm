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

mkdir -p $HOME/.terraform.d/plugins


[contrail@server2 ~]$ go get github.com/kimcharli/terraform-provider-libvirt

[contrail@server2 ~]$ go list go/src/ ...

...
github.com/kimcharli/terraform-provider-libvirt
github.com/kimcharli/terraform-provider-libvirt/libvirt
github.com/kimcharli/terraform-provider-libvirt/libvirt/helper/suppress
[contrail@server2 ~]$ 
[contrail@server2 ~]$ cd go/src/github.com/kimcharli/terraform-provider-libvirt/
[contrail@server2 terraform-provider-libvirt]$ go list
github.com/kimcharli/terraform-provider-libvirt
[contrail@server2 terraform-provider-libvirt]$
[contrail@server2 terraform-provider-libvirt]$ go test -v
=== RUN   TestPrintVersion
--- PASS: TestPrintVersion (0.08s)
PASS
ok      github.com/kimcharli/terraform-provider-libvirt 0.186s
[contrail@server2 terraform-provider-libvirt]$ 
[contrail@server2 terraform-provider-libvirt]$ go install
[contrail@server2 terraform-provider-libvirt]$ ls -l $GOPATH/bin
total 32256
-rwxrwxr-x. 1 contrail contrail 33026584 Nov 17 18:26 terraform-provider-libvirt
[contrail@server2 terraform-provider-libvirt]$ 


[contrail@server2 terraform-provider-libvirt]$ cp $GOPATH/bin/terraform-provider-libvirt $HOME/.terraform.d/plugins 
[contrail@server2 terraform-provider-libvirt]$ ls -l $HOME/.terraform.d/plugins 
total 32256
-rwxrwxr-x. 1 contrail contrail 33026584 Nov 17 18:27 terraform-provider-libvirt
[contrail@server2 terraform-provider-libvirt]$ 

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
Error: [WARN] Cannot find machine type pc-i440fx-rhel7.6.0 for hvm/x86_64 in {{ capabilities} {32353537-3835-584d-5136-32303033574a 0xc0003b5040 0xc0004daec0 0xc000359320 0xc000359350 0xc000011460 0xc0004b68c0 <nil> [{selinux 0 [{kvm system_u:system_r:svirt_t:s0} {qemu system_u:system_r:svirt_tcg_t:s0}]} {dac 0 [{kvm +107:+107} {qemu +107:+107}]}]} [{hvm {i686 32 /usr/bin/qemu-system-i386  [{pc-i440fx-2.0 255 } {pc 255 pc-i440fx-2.0} {pc-0.12 255 } {pc-1.3 255 } {pc-q35-1.6 255 } {pc-q35-1.5 255 } {pc-i440fx-1.6 255 } {pc-i440fx-1.7 255 } {pc-0.11 255 } {pc-0.10 255 } {pc-1.2 255 } {isapc 1 } {pc-q35-1.4 255 } {pc-0.15 255 } {pc-0.14 255 } {pc-i440fx-1.5 255 } {pc-q35-2.0 255 } {q35 255 pc-q35-2.0} {pc-i440fx-1.4 255 } {pc-1.1 255 } {pc-q35-1.7 255 } {pc-1.0 255 } {pc-0.13 255 }] [{qemu  []} {kvm /usr/libexec/qemu-kvm [{pc-i440fx-rhel7.6.0 240 } {pc 240 pc-i440fx-rhel7.6.0} {pc-i440fx-rhel7.0.0 240 } {pc-q35-rhel7.6.0 384 } {q35 384 pc-q35-rhel7.6.0} {rhel6.3.0 240 } {rhel6.4.0 240 } {rhel6.0.0 240 } {pc-i440fx-rhel7.5.0 240 } {pc-i440fx-rhel7.1.0 240 } {pc-i440fx-rhel7.2.0 240 } {pc-q35-rhel7.3.0 255 } {rhel6.5.0 240 } {pc-q35-rhel7.4.0 384 } {rhel6.6.0 240 } {rhel6.1.0 240 } {rhel6.2.0 240 } {pc-i440fx-rhel7.3.0 240 } {pc-i440fx-rhel7.4.0 240 } {pc-q35-rhel7.5.0 384 }]}]} 0xc000384c80} {hvm {x86_64 64 /usr/bin/qemu-system-x86_64  [{pc-i440fx-2.0 255 } {pc 255 pc-i440fx-2.0} {pc-1.3 255 } {pc-0.12 255 } {pc-q35-1.6 255 } {pc-q35-1.5 255 } {pc-i440fx-1.6 255 } {pc-i440fx-1.7 255 } {pc-0.11 255 } {pc-1.2 255 } {pc-0.10 255 } {isapc 1 } {pc-q35-1.4 255 } {pc-0.15 255 } {pc-0.14 255 } {pc-i440fx-1.5 255 } {pc-i440fx-1.4 255 } {pc-q35-2.0 255 } {q35 255 pc-q35-2.0} {pc-1.1 255 } {pc-q35-1.7 255 } {pc-1.0 255 } {pc-0.13 255 }] [{qemu  []} {kvm /usr/libexec/qemu-kvm [{pc-i440fx-rhel7.6.0 240 } {pc 240 pc-i440fx-rhel7.6.0} {pc-i440fx-rhel7.0.0 240 } {pc-q35-rhel7.6.0 384 } {q35 384 pc-q35-rhel7.6.0} {rhel6.3.0 240 } {rhel6.4.0 240 } {rhel6.0.0 240 } {pc-i440fx-rhel7.5.0 240 } {pc-i440fx-rhel7.1.0 240 } {pc-i440fx-rhel7.2.0 240 } {pc-q35-rhel7.3.0 255 } {rhel6.5.0 240 } {pc-q35-rhel7.4.0 384 } {rhel6.6.0 240 } {rhel6.1.0 240 } {rhel6.2.0 240 } {pc-i440fx-rhel7.3.0 240 } {pc-i440fx-rhel7.4.0 240 } {pc-q35-rhel7.5.0 384 }]}]} 0xc0003879c0}]}

```

to workaround above;
```
sudo mv /usr/bin/qemu-system-x86_64 /usr/bin/qemu-system-x86_64.backup
sudo ln -s /usr/libexec/qemu-kvm /usr/bin/qemu-system-x86_64
```
