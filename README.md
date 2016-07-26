# Creating Volatility Profile for 'victoria-v8-memdump.img'

Here is the shell script for executing all the task mentioned below.

"wget --no-check-certificate https://raw.githubusercontent.com/BuckBoost/volatility_victoria/master/profile.sh"

Image given for analysis - victoria-v8.memdump.img

Step 1:

Download the victoria-v8.memdump.img

wget http://www.honeynet.org/challenge2011/downloads/victoria-v8.memdump.img.zip

Find out the kernel information buy using the 'strings' command

strings victoria-v8.memdump.img | grep vmlinuz

Accordingly, download Debian 5 Lenny from www.debian.org
--You can choose from different types of installation sources.

https://www.debian.org/releases/lenny/debian-installer/

For minimal installation use the netinst CD image - i386 (152 MB)

http://cdimage.debian.org/cdimage/archive/5.0.10/i386/iso-cd/debian-5010-i386-netinst.iso

Step 2:

Install the Debian Lenny in VMWARE or in Virtual Box (minimal installation)

Step 3:

Now you need to update the source list with working repository. Here are the list of the working repositories which need to be added.

edit the /etc/apt/source.lst file in vim and add the following entries.
--if CDROM error shows up, do comment the cd-rom lines in the source.lst

deb http://archive.debian.org/debian/ lenny contrib main non-free
deb http://archive.debian.org/debian-security lenny/updates main
deb-src http://archive.debian.org/debian/ lenny contrib main non-free
deb-src http://archive.debian.org/debian-security lenny/updates main

run the following commands as root or a sudoer:

apt-get update -y
apt-get -f install -y
apt-get install linux-headers-$(uname -r) -y

let the update complete 

Step 3:

Now we will get the volatility framework from github. 
Lets first install zip and unzip tool. Though we can do using tar command.

apt-get install zip unzip -y

wget --no-check-certificate https://github.com/volatilityfoundation/volatility/archive/master.zip -O /volatility.zip ; unzip /volatility.zip -d / ; mv /volatility-master /volatility

Step 4: (not necessary if you are not analysing the file in Debain 5 Lenny) 

Now we need to install Python 2.5 or later verson as the volatility framework 2.5 requires it for its analysis.

First we need to install some prerequisite packages.

apt-get install build-essential libsqlite3-dev zlib1g-dev libncurses5-dev libgdbm-dev libbz2-dev libreadline5-dev libssl-dev libdb-dev -y

Now lets get Python tarball and install it.

wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz

tar -xzf Python-2.7.12.tgz
cd Python-2.7.12

./configure --prefix=/usr --enable-shared
make
make install

Type python in the terminal and check the version. (type exit() to exit)

Step 5:

Now lets get into the making volatility linux profile.

Install dwarfdump package  

apt-get install dwarfdump make -y

Switch the working directory to volatility/tools/linux
run the 'make' command and if executed successfully, you will see a module.dwarf file created.

We need to zip this file along with a critical file associated with our Debian distribution kernel called 'System.map'. In our case its 'System.map-2.6.26-2-686'

zip /volatility/volatility/plugins/overlays/linux/Debian5_26.zip /volatility/tools/linux/module.dwarf /boot/System.map-2.6.26-2-686

Now from on, we can carry around our 'Debian5_26.zip' file and copy it to '/volatility/plugins/overlay/linux' directory to analyse our 'victoria-v8.memdump.img' file from a different kernel machine. 

And hence the volatility profile is created.

  ____                   _      ____                          _   
 |  _ \                 | |    |  _ \                        | |  
 | |_) |  _   _    ___  | | __ | |_) |   ___     ___    ___  | |_ 
 |  _ <  | | | |  / __| | |/ / |  _ <   / _ \   / _ \  / __| | __|
 | |_) | | |_| | | (__  |   <  | |_) | | (_) | | (_) | \__ \ | |_ 
 |____/   \__,_|  \___| |_|\_\ |____/   \___/   \___/  |___/  \__|
                                                                  
                                                                  
 

 
