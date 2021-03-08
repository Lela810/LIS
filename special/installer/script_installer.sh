!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi



clear

echo
echo
echo "Your Scrips are now located in /home/administrator"
echo 
echo


echo
echo "Do you wanna to set a Static IP? y/n:"
read static
echo
echo

if [ "$static" == "y" ]; then 
./setup_ip.sh
echo
echo
echo "Your IP is now set Static!"
exit 0
fi


echo
echo "Do you wanna install Linux Integration Services for Hyper-V? y/n:"
read ubuntulis
echo
echo


echo
echo "Do you wanna install Auto-update? y/n:"
read autoupdate
echo
echo


echo
echo "Do you wanna install Webmin? y/n:"
read webmin
echo
echo


echo
echo "Do you wanna install a Snowl-Sensor? y/n:"
read snowl
echo
echo




#install needed Tools
apt update && apt -y upgrade
apt -y install git grep




#Download Scripts Repo
cd /tmp/
git clone https://github.com/Lela810/Scripts
cd ./Scripts
cd ./linux
chmod +x *
mv * /home/administrator
cd /home/administrator
rm -r /tmp/Scripts





if [ "$ubuntulis" == "y" ]; then 
./setup_ubuntulis.sh
echo
echo
echo "Linux Integration Services installed!"
fi

if [ "$autoupdate" == "y" ]; then 
./setup_autoupdate.sh
echo
echo
echo "Auto-update installed!"
fi

if [ "$webmin" == "y" ]; then 
./setup_webmin.sh
echo
echo
echo "Webmin installed!"
fi

if [ "$snowl" == "y" ]; then 
./setup_snowlsensor.sh
echo
echo
echo "Snowl-Sensor installed!"
fi

./setup_updater.sh


rm setup*



#reboot
if [ -f /var/run/reboot-required ]; then
echo ***System needs to be rebooted***
echo
echo "Do you wanna Reboot now? y/n:"
read reboot
echo
echo
fi



if [ "$reboot" == "y" ]; then 
echo "Rebooting Now!"
echo
reboot
fi
