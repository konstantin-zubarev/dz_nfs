#!/bin/bash
# Install
yum install nfs-utils -y
systemctl start rpcbind
systemctl enable rpcbind
mkdir /mnt/nfs_share
echo -e "[Unit] \nDescription = Mount NFS Share \n \n[Mount] \nWhat = 192.168.50.10:/opt/nfs_share \nWhere = /mnt/nfs_share \nType = nfs \nOptions = defaults \n \n[Install] \nWantedBy = multi-user.target" > /etc/systemd/system/mnt-nfs_share.mount
systemctl start mnt-nfs_share.mount
systemctl enable mnt-nfs_share.mount
