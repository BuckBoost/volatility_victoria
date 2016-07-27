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

apt-get install zip unzip dwarfdump make python -y

# Downloading and extracting volatility framework 2.5

wget --no-check-certificate https://github.com/volatilityfoundation/volatility/archive/master.zip -O /volatility.zip ; unzip /volatility.zip -d / ; mv /volatility-master /volatility

# Creating the 'module.dwarf' file

cd /volatility/tools/linux
make

# Creating profile for Debian kernel 2.6.26-2-686

zip /volatility/volatility/plugins/overlays/linux/Debian5_26.zip /volatility/tools/linux/module.dwarf /boot/System.map-2.6.26-2-686

cd /volatility/volatility/plugins/overlays/linux/

mkdir /profiles
cp Debian5_26.zip /profiles
cd /profiles

clear



echo  "____                   _      ____                          _   "
echo  "|  _ \                 | |    |  _ \                        | |  "
echo  "| |_) |  _   _    ___  | | __ | |_) |   ___     ___    ___  | |_ "
echo  "|  _ <  | | | |  / __| | |/ / |  _ <   / _ \   / _ \  / __| | __|"
echo  "| |_) | | |_| | | (__  |   <  | |_) | | (_) | | (_) | \__ \ | |_ "
echo  "|____/   \__,_|  \___| |_|\_\ |____/   \___/   \___/  |___/  \__|"
                                                                  
echo ""
echo ""

echo The file Debian5_26.zip is available at http://$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'):8000

echo ""
echo ""
python -m SimpleHTTPServer                         
                                                                 
