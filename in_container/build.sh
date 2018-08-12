#!/bin/bash
source /in_container/in_chroot/functions/functions.sh

cd /in_container

create_disk 8192

apt-get update
apt-get install -y debootstrap

_echo "Bootstrapping target OS"
debootstrap stable /target http://deb.debian.org/debian/

make_fstab
prepare_chroot

cp -rp /in_container/in_chroot /target
chroot /target /in_chroot/build.sh

disk_clean

umount_disk

exit
