#!/bin/bash

packerfile="debian-amd64-proxmox.pkr.hcl"

# Paramètres du Proxmox
export proxmox_url="https://IP_PROXMOX:8006/api2/json"
export proxmox_node="NOM_NOEUD"
export proxmox_username="root@pam"
export proxmox_password="Password" # Il est préférable d'utiliser un utilisateur dédié à Proxmox
export proxmox_vm_storage="local-zfs"
export proxmox_iso_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"
export proxmox_iso_checksum="sha256:23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
export proxmox_iso_storage="local"
export proxmox_network="vmbr0"

# Ressources attribuées à la VM
export vm_id=9000
export vm_name="debian-12-tf"
export template_description="VM debian"
export vm_default_user="root"
export vm_cpu=2
export vm_disk="8G"
export vm_memory=2048

# Paramètres de la VM Template
export prefix_disk="vd"
export ssh_username="root"
export ssh_password="HugePassword"
export userdeploy_password="HugePassword"

export vm_keys=$(echo "$(cat ~/.ssh/id_ed25519.pub)")
#export vm_keys=$(echo "$(cat ./KeyDEPLOY.id_rsa.pub)\n$(cat ./KeyINFRA.id_rsa.pub)\n$(cat ~/.ssh/id_rsa.pub)")

# set variables
j2 http/preseed.cfg.j2 > http/preseed.cfg

#PACKER_LOG=1 packer build $packerfile
packer init $packerfile
packer build $packerfile

rm -f http/preseed.cfg

