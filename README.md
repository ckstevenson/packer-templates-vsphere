# Packer Templates
This repository contains the vsphere builder for Packer Templates I use for my local development machine.

### TODO
- [ ] Add arch from the QEMU project

## Environment Variables
All provisioning is done by Ansible and a few environment variables must be set globally or locally. Local is best on shared machines. Use either ~/.profile or ~/.bash\_profile or perhaps whatever shell you choose to use. A good way to do this is to have everythin in ~/.profile and have your shell of choice source that. exporting the variables in the current shell is also an option,
* export PKR\_VAR\_ansible\_playbooks=
* export PKR\_VAR\_connection\_username=

## Usage
* All below templates can be deployed with --force to overwrite the existing template
* All variable declarations are in variables.pkr.hcl
* All Windows templates are built from the vsphere-iso.windows source
* All Linux templates are built from the vsphere-iso.linux source
* All sources are in vsphere.pkr.hcl
* vSphere credentials can be stored in credentials.auto.pkrvars.hcl, which would then be auto loaded]
* All Autounattend, preseed or kickstart files are in boot\_config direectory

One could set vCenter specific variables via a vars file or environment variables. These variables are as follows:

* vcenter\_server = ""
* vcenter\_cluster = ""
* vcenter\_datacenter = ""    
* vcenter\_host = ""
* vcenter\_datastore = ""
* vcenter\_folder = ""


### Linux
#### Debian 10
```
packer build --only vsphere.linux --var-file=centos.pkrvars.hcl .
```

#### CentOS Stream 8
```
packer build --only vsphere.linux --var-file=debian.pkrvars.hcl .
```
#### Arch Linux
```
packer build --only vsphere.arch --var-file=arch.pkrvars.hcl .
```

### Windows
#### Server 2019
```
packer build --only vsphere-iso.windows --var-file=2019.pkrvars.hcl --var-file= .
```

#### Server 2012
```
packer build --only vsphere-iso.windows --var-file=2012.pkrvars.hcl --var-file= .
```
#### Server 2016
```
packer build --only vsphere-iso.windows --var-file=2016.pkrvars.hcl --var-file= .
```
