# useradd -m -s /bin/bash pbeyloun && echo "pbeyloun:aboukess" |  chpasswd



# chmod a-w /home/pbeyloun

# mkdir -p /home/pbeyloun/ftp
# chown pbeyloun:pbeyloun /home/pbeyloun/ftp
# chmod 755 /home/pbeyloun/ftp


# vsftpd
#!/bin/bash


mkdir -p /var/run/vsftpd/empty

# Create the FTP user# 
useradd -m -d /home/pbeyloun -s /bin/bash pbeyloun
echo "pbeyloun:password" | chpasswd

chmod 555 /home/pbeyloun
mkdir /home/pbeyloun/volume

vsftpd
# Create an FTP directory inside the home folder
# mkdir -p /var/run/vsftpd/empty
# mkdir -p /home/pbeyloun/ftp
# chown -R pbeyloun:pbeyloun /home/pbeyloun/ftp
# chmod 755 /home/pbeyloun/ftp

# Fix the home directory permissions to avoid vsftpd chroot error
# chmod a-w /home/pbeyloun

# Start vsftpd
# vsftpd /etc/vsftpd.conf
# make 