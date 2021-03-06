#!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi




#For if static ip


apt -y install net-tools network-manager



cat /etc/netplan/00-installer-config.yaml
echo
echo
echo "What Interface should get it? default:ens18 :"
read interface
echo
echo

if [ "$interface" == "" ]; then
interface=ens18
fi


ifconfig $interface | grep "inet"

echo
echo
echo "What IP should it get?:"
read ip
echo
echo

if [ "$ip" == "" ]; then
echo "An empty IP is not legal!"
exit 1
fi

echo
echo "What Subnetmask should it get? default:24 :"
read sm
echo
echo

if [ "$sm" == "" ]; then
sm=24
fi

echo
echo "What Gateway should it get? default:192.168.1.1 :"
read gw
echo
echo

if [ "$gw" == "" ]; then
gw=192.168.1.1
fi


echo
echo "Do you wanna change the default DNS servers?(Primary: 192.168.1.112, Secondary: 192.168.1.110) y/n:"
read changedns
echo
echo

if [ "$changedns" == "y" ]; then

echo
echo "What should be your Primary DNS? default:192.168.1.112 :"
read primarydns
echo
echo




echo
echo "What should be your Secondary DNS? default:8.8.8.8 :"
read secondarydns
echo
echo

fi


if [ "$primarydns" == "" ]; then
primarydns=192.168.1.112
fi

if [ "$secondarydns" == "" ]; then
secondarydns=8.8.8.8
fi


if grep -q "dhcp4: no" /etc/netplan/00-installer-config.yaml; then
rm /etc/netplan/00-installer-config.yaml
cp ./config/00-installer-config.yaml /etc/netplan/
fi

#Set Fixed ip

echo "Your System will be available under: $ip/$sm"
echo

        sed -i "s/$interface:/$interface:\n      dhcp4: no\n      dhcp6: no\n      addresses: [$ip\/$sm]\n      gateway4: $gw\n      nameservers:\n        search: [klaus.local]\n        addresses: [$primarydns, $secondarydns]/" /etc/netplan/00-installer-config.yaml
        sed -i "s/dhcp4: true//" /etc/netplan/00-installer-config.yaml
		sed -i "s/dhcp6: true//" /etc/netplan/00-installer-config.yaml


