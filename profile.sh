# Updating source list  
echo "deb http://archive.debian.org/debian/ lenny contrib main non-free" > /etc/apt/sources.list
echo deb "http://archive.debian.org/debian-security lenny/updates main" >> /etc/apt/sources.list 
echo deb-src "http://archive.debian.org/debian/ lenny contrib main non-free" >> /etc/apt/sources.list 
echo "deb-src http://archive.debian.org/debian-security lenny/updates main" >> /etc/apt/sources.list

# Updating repository

apt-get update -y
apt-get -f install -y
apt-get install linux-headers-$(uname -r) -y

# Installing required packages

apt-get zip unzip dwarfdump -y

# Downloading and extracting volatility framework 2.5

wget https://github.com/volatilityfoundation/volatility/archive/master.zip -O volatility.zip ; unzip volatility.zip -d / ; mv /volatility-master /volatility

# Creating the 'module.dwarf' file

cd /volatility/tools/linux
make

# Creating profile for Debian kernel 2.6.26-2-686

zip /volatility/plugins/overlays/linux/Debian5_26.zip /volatility/tools/linux/module.dwarf /boot/System.map-2.6.26-2-686


