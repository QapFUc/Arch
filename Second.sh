#!/bin/bash
cp /Arch/locale.gen /etc/locale.gen
locale-gen
cp /Arch/mkinitcpio.conf /etc/mkinitcpio.conf 
mkinitcpio -p linux
bootctl install --path=/boot
cp /Arch/loader.conf /boot/loader/loader.conf
cp /Arch/arch.conf /boot/loader/entries/arch.conf
useradd -m -G users,wheel -s /bin/bash qapfuc
systemctl enable dhcpcd.service NetworkManager
