
#!/bin/bash
echo "Make 2 partition first for boot and second for root."
read Yes
pvcreate /dev/mapper/cryptdisk
vgcreate root /dev/mapper/cryptdisk
lvcreate -L 20G root -n swap
lvcreate -l 100%FREE root -n root
mkfs.fat -F32 /dev/sda1
mkswap /dev/mapper/root-swap
mkfs.btrfs -f /dev/mapper/root-root
mount /dev/mapper/root-root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/mapper/root-swap
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware dhcpcd networkmanager mesa-demos btrfs-progs sudo p7zip git vim xorg net-tools iproute2 lvm2
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
