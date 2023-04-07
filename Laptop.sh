#!/bin/bash
echo "Make 2 partition first for boot and second for root."
read Yes
mkfs.vfat /dev/nvme0n1p1
mkfs.btrfs -f /dev/mapper/cryptdisk
mount /dev/mapper/cryptdisk /mnt
umount -R /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt base base-devel linux linux-headers linux-firmware dhcpcd networkmanager mesa-demos btrfs-progs sudo p7zip git vim xorg net-tools iproute2
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
