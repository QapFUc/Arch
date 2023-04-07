#!/bin/bash
mkfs.vfat /dev/nvme0n1p1
mkfs.btrfs -f /dev/mapper/cryptdisk
mount /dev/mapper/cryptdisk /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount -R /mnt
mount -o subvol=@,compress=lzo,ssd,autodefrag /dev/mapper/cryptdisk /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/sda1 /mnt/boot
mount -o subvol=@home,compress-lzo,ssd,autodefrag /dev/mapper/cryptdisk /mnt/home
pacstrap /mnt base base-devel linux linux-headers linux-firmware dhcpcd networkmanager mesa-demos btrfs-progs sudo p7zip git vim xorg
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
