#!/bin/bash

function Welcome()
{
clear
echo -n "        Local Time :   " && date "+%F [%T]      ";
echo    "    ============================================";
echo    "    |        1-key LotSpeeder Installer        |";
echo    "    |                                          |";
echo    "    |               --By:  Andls               |";
echo    "    |                2017-03-01                |";
echo    "    ============================================";
echo    "";
rootness;
cd /root
}

function rootness()
{
if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi
}

function pause()
{
read -n 1 -p "Press Enter to Continue..." INP
if [ "$INP" != '' ] ; then
echo -ne '\b \n'
echo "";
fi
}

function Check()
{
echo 'Preparatory work...'
apt-get >/dev/null 2>&1
[ $? -le '1' ] && apt-get -y -qq install curl grep unzip ethtool >/dev/null 2>&1
yum >/dev/null 2>&1
[ $? -le '1' ] && yum -y -q install which sed curl grep awk unzip ethtool >/dev/null 2>&1
[ -f /etc/redhat-release ] && KNA=$(awk '{print $1}' /etc/redhat-release)
[ -f /etc/os-release ] && KNA=$(awk -F'[= "]' '/PRETTY_NAME/{print $3}' /etc/os-release)
[ -f /etc/lsb-release ] && KNA=$(awk -F'[="]+' '/DISTRIB_ID/{print $2}' /etc/lsb-release)
KNB=$(getconf LONG_BIT)
ifconfig >/dev/null 2>&1
[ $? -gt '1' ] && echo -ne "I can not run 'ifconfig' successfully! \nPlease check your system, and try again! \n\n" && exit 1;
Eth=$(ifconfig |grep -B1 "$(wget -qO- ipv4.icanhazip.com)" |awk -F '[: ]' '/eth/{ print $1 }') 
[ -n "$Eth" ] && NumEth=$(ifconfig |awk -F '[: ]' '/eth/{ print $1 }' |sed -n '$=')
[ -z "$Eth" ] && echo -ne "It is seem that you server not as usually. \nPlease input your public Ethernet: " && read tmpEth;
tmpEth=$(echo "$tmpEth"|sed 's/[ \t]*//g') && [ -n "$tmpEth" ] && [ -z $(echo "$tmpEth" |grep -E -i "venet") ] && [[ -n $(ifconfig |grep -E "$tmpEth") ]] && Eth="$tmpEth";
[ -z "$Eth" ] && echo "I can not find the server pubilc Ethernet! " && exit 1
URLKernel='https://raw.githubusercontent.com/0oVicero0/serverSpeeder_kernel/master/serverSpeeder.txt'
MyKernel=$(curl -k -q --progress-bar "$URLKernel" |grep "$KNA/" |grep "/x$KNB/" |grep "/$KNK/" |sort -k3 -t '_' |tail -n 1)
[ -z "$MyKernel" ] && echo -ne "Kernel not be matched! \nYou should change kernel manually, and try again! \n\nView the link to get detaits: \n"$URLKernel" \n\n\n" && exit 1
pause;
}

function SelectKernel()
{
KNN=$(echo $MyKernel |awk -F '/' '{ print $2 }') && [ -z "$KNN" ] && Unstall && echo "Error,Not Matched! " && exit 1
KNV=$(echo $MyKernel |awk -F '/' '{ print $5 }') && [ -z "$KNV" ] && Unstall && echo "Error,Not Matched! " && exit 1
wget --no-check-certificate -q -O "/root/appex/apxfiles/bin/acce-"$KNV"-["$KNA"_"$KNN"_"$KNK"]" "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_kernel/master/$MyKernel"
[ ! -f "/root/appex/apxfiles/bin/acce-"$KNV"-["$KNA"_"$KNN"_"$KNK"]" ] && Unstall && echo "Download Error,Not Found acce-$KNV-[$KNA_$KNN_$KNK]! " && exit 1
}

function Install()
{
Welcome;
Check;
ServerSpeeder;
dl-Lic;
bash /root/appex/install.sh
rm -rf /root/appex* >/dev/null 2>&1
Service;
clear
bash /appex/bin/lotServer.sh status
exit 0
}

function Unstall()
{
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/init.d/lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc2.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc3.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc4.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc5.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc0.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc1.d/*lotServer >/dev/null 2>&1
[ -d /etc/rc.d ] && rm -rf /etc/rc.d/rc6.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/init.d/lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc2.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc3.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc4.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc5.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc0.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc1.d/*lotServer >/dev/null 2>&1
[ -d /etc/init.d ] && rm -rf /etc/rc6.d/*lotServer >/dev/null 2>&1
rm -rf /etc/lotServer.conf >/dev/null 2>&1
chattr -R -i /appex >/dev/null 2>&1
bash /appex/bin/lotServer.sh uninstall -f >/dev/null 2>&1
rm -rf /appex >/dev/null 2>&1
rm -rf /root/appex* >/dev/null 2>&1
echo -ne 'lotServer have been removed! \n\n\n'
exit 0
}

function dl-Lic()
{
chattr -R -i /appex >/dev/null 2>&1
rm -rf /appex >/dev/null 2>&1
mkdir -p /appex/etc
mkdir -p /appex/bin
[ -n "$NumEth" ] && [ "$NumEth" -ne '1' ] && Eth='eth0'
MAC=$(ifconfig "$Eth" |awk '/HWaddr/{ print $5 }')
[ -z "$MAC" ] && MAC=$(ifconfig "$Eth" |awk '/ether/{ print $2 }')
[ -z "$MAC" ] && Unstall && echo "Not Found MAC address! " && exit 1
wget --no-check-certificate -q -O "/appex/etc/apx.lic" "http://serverspeeder.azurewebsites.net/lic?mac=$MAC"
[ "$(du -b /appex/etc/apx.lic |awk '{ print $1 }')" -ne '152' ] && Unstall && echo "Error! I can not generate the Lic for you, Please try again later! " && exit 1
echo "Lic generate success! "
chattr +i /appex/etc/apx.lic
[ -n $(which ethtool) ] && rm -rf /appex/bin/ethtool && cp -f $(which ethtool) /appex/bin
}

function ServerSpeeder()
{
[ ! -f /root/appex.zip ] && wget --no-check-certificate -q -O "/root/appex.zip" "https://github.com/AndlsH/LotServer/releases/download/LATEST/appex.zip"
[ ! -f /root/appex.zip ] && Unstall && echo "Error: "appex.zip" not found! " && exit 1
mkdir -p /root/appex
unzip -o -d /root/appex /root/appex.zip
SelectKernel;
APXEXE=$(ls -1 /root/appex/apxfiles/bin |grep 'acce-')
sed -i "s/^accif\=.*/accif\=\"$Eth\"/" /root/appex/apxfiles/etc/config
sed -i "s/^apxexe\=.*/apxexe\=\"\/appex\/bin\/$APXEXE\"/" /root/appex/apxfiles/etc/config
}

function Service()
{
    bash /appex/bin/lotServer.sh stop
    cat > /lib/systemd/system/appex.service <<- EOF
[Unit]
Description=AppEx LotServer
After=network.target
[Service]
Type=forking
ExecStart=/appex/bin/lotServer.sh start
ExecReload=/appex/bin/lotServer.sh restart
ExecStop=/appex/bin/lotServer.sh stop
PrivateTmp=true
[Install]
WantedBy=multi-user.target
EOF
    systemctl enable appex
    systemctl start appex
}

[ $# == '1' ] && [ "$1" == 'install' ] && KNK="$(uname -r)" && Install;
[ $# == '1' ] && [ "$1" == 'unstall' ] && Welcome && pause && Unstall;
[ $# == '2' ] && [ "$1" == 'install' ] && KNK="$2" && Install;
echo -ne "Usage:\n     bash $0 [install |unstall |install '{lotServer of Kernel Version}']\n"
