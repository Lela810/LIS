#!/bin/bash 


# Clear Current Screen
clear


#Remove old updater files
cd /root/updater
rm *_updater.sh
rm up.sh

rm *.sh.*

apt remove telegraf


#Update



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/autoupdate_updater.sh



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *


./autoupdate_updater.sh
./installer_updater.sh
./up.sh

