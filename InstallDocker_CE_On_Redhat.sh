#!/usr/bin/env bash
if [[ $(id -u) -ne 0 ]]
then
	echo "Please run this script from root only"
	exit 1
fi
if [[ $(cat /etc/os-release | awk -F= '/NAME=/  && NR==1 { print $2 }' | tr -d '"' | tr [A-Z] [a-z] ) != 'red hat enterprise linux' ]]
then
	echo "This script works for only Red Hat Linux"
	echo "Thank you!!!"
	exit 2
fi
echo "###################################################################################"
echo "# OS is identified as Red Hat                                                     #"
echo "# This Script will remove old docker components and install latest stable docker  #"
echo "###################################################################################"
sleep 1
echo "==> Removing older version of docker if any...."
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate \
                  docker-engine podman runc -y 2>/dev/null


echo "==> Updating exiting list of packagesss..."
yum update -y

echo "==> Installing dependencies......."
##apt install apt-transport-https ca-certificates curl software-properties-common -y

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

##echo "==> Adding the GPG key for the official Docker repository to your system..."
##curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

##echo "==> Adding the Docker repository to APT sources:.."
##add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y

echo "==> Update the package database with the Docker packages from the newly added repo..."
yum update -y

echo "==> Installing Docker ...."
sudo yum install docker-ce -y | head -5
sudo yum install docker-ce-cli -y | head -5
sudo yum install containerd.io -y | head -5
sudo yum install docker-buildx-plugin -y | head -5
sudo yum install docker-compose-plugin -y | head -5

if [[ $? -ne 0 ]]
then
	echo "====>  Sorry Failed to install Docker. Try it manually  <===="
	exit 2
fi
echo "====>  Docker has been installed successfully on this host - $(hostname -s)  <===="
sudo chmod 666 /var/run/docker.sock
if systemctl status docker &>/dev/null 
then
	echo "====>  And it is up and running... You can verify it using cmd: systemctl status docker  <===="
else
	echo "====>  But it is not running. You can start it manually using cmd: systemctl start docker  <===="
fi
<< comment
echo "#############################################"
echo "# Now, You can play with docker             #"
echo "# Docker Info on $(hostname -s) is: #"
echo "# Docker Engine Version is: $(docker --version | cut -d " " -f3 | tr -d ",") #"
echo "#############################################"
comment
