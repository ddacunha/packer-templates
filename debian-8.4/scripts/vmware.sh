apt-get -y install open-vm-tools build-essential linux-headers-$(uname -r)

# from http://technologist.pro/devops/infrastructure-as-code-create-linux-rhelcentos-base-images-using-packer

VMWARE_ISO=/tmp/vmware_tools_linux.iso
VMWARE_MNTDIR=$(mktemp --tmpdir=/tmp -q -d -t vmware_mnt_XXXXXX)
VMWARE_TMPDIR=$(mktemp --tmpdir=/tmp -q -d -t vmware_XXXXXX)

# Extract tools
mount -o loop $VMWARE_ISO $VMWARE_MNTDIR
tar zxf $VMWARE_MNTDIR/VMwareTools*.tar.gz -C $VMWARE_TMPDIR
umount $VMWARE_MNTDIR

# Install tools
$VMWARE_TMPDIR/vmware-tools-distrib/vmware-install.pl -d

# Clean up
rm -f $VMWARE_ISO
rm -rf $VMWARE_MNTDIR
rm -rf $VMWARE_TMPDIR

echo -n ".host :/ /mnt/hgfs vmhgfs defaults 0 0" >> /etc/fstab
