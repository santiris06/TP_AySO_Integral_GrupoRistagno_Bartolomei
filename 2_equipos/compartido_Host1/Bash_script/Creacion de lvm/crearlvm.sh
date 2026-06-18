#!/bin/bash

DISCO_DATOS="/dev/sdc"  
DISCO_SWAP_A="/dev/sdd"  
DISCO_SWAP_B="/dev/sde" 
DISCO_SWAP_EST="/dev/sdf"



sudo pvcreate -ff -y $DISCO_DATOS $DISCO_SWAP_A $DISCO_SWAP_B

sudo vgcreate vg_datos $DISCO_DATOS
sudo vgcreate vg_temp $DISCO_SWAP_A $DISCO_SWAP_B

sudo lvcreate -L 10M -n lv_docker vg_datos
sudo lvcreate -L 2.5G -n lv_workareas vg_datos
sudo lvcreate -L 2.5G -n lv_swap vg_temp

sudo mkdir -p /var/lib/docker/
sudo mkdir -p /work/

sudo mkfs.ext4 -F /dev/vg_datos/lv_docker
sudo mount /dev/vg_datos/lv_docker /var/lib/docker/

sudo mkfs.ext4 -F /dev/vg_datos/lv_workareas
sudo mount /dev/vg_datos/lv_workareas /work/

sudo mkswap /dev/vg_temp/lv_swap
sudo swapon /dev/vg_temp/lv_swap



sudo mkswap $DISCO_SWAP_EST
sudo swapon $DISCO_SWAP_EST