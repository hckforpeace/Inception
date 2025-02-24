#!/bin/bash
mkdir -p /var/run/vsftpd/empty

# Create the FTP user# 
useradd -m -d /home/pbeyloun -s /bin/bash $(cat /run/secrets/ftp_uname)
echo "$(cat /run/secrets/ftp_uname):$(cat /run/secrets/ftp_pw)" | chpasswd

chmod 555 /home/pbeyloun
mkdir -p /home/pbeyloun/volume

vsftpd