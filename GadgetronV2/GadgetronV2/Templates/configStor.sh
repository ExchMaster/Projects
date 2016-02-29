#!/bin/bash
#Install SMB Protocol suppport 
apt-get -qq install cifs-utils -y

#Create directory, udpate fstab, mount Azure file share
mkdir -p /AzFiles/$2
echo "//$1.file.core.windows.net/$2 /AzFiles/$2 cifs vers=3.0,username=$1,password=$3,dir_mode=0777,file_mode=0777" >> /etc/fstab
mount -a

#Download script, update crontab, copy files as needed to get VMSS Instance ID
wget https://raw.githubusercontent.com/ExchMaster/Projects/master/GadgetronV2/GadgetronV2/Templates/instID.sh -P /bin -N -q
chmod +x /bin/instID.sh
/bin/instID.sh
cp /10.0.247.* /AzFiles/$2
echo "@reboot root /bin/instID.sh" >> /etc/crontab
echo "* * * * * root /bin/instID.sh" >> /etc/crontab
echo "* * * * * root cp /10.0.247.* /AzFiles/$2" >> /etc/crontab
