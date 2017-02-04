-----------------------------   
#\#  serverSpeeder Install  \#                           
-----------------------------      
----------------------------- 
#For Linux (simple)   
Usage    
```
Usage:     
      bash appex.sh [install |unstall |install '{lotServer of Kernel Version}']     
```
Install
```
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeser_Install/master/appex.sh && chmod +x appex.sh && bash appex.sh install

```    
Unstall    
```
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeser_Install/master/appex.sh && chmod +x appex.sh && bash appex.sh unstall

```  
----------------------------- 
-----------------------------
部分用法说明(制作一键脚本或手动安装,仅供学习测试使用)
-----------------------------
具体用哪个加速模块检索这个文件,选择最合适的.         
```
https://github.com/0oVicero0/serverSpeeder_kernel/blob/master/serverSpeeder.txt
```
改加速模块文件名字.       
下载链接如下(变量$1,$2,$3,$4,$5,$6)   
```
https://raw.githubusercontent.com/0oVicero0/serverSpeeder_kernel/master/$1/$2/$3/$4/$5/$6
```
下载后的加速模块文件名改成这样  ```acce-$5-[$1_$2_$3]```         
如果不改名字,可能会触发某个BUG(Debian下会触发,别的系统没用过,不清楚.)        
许可证在这里生成: ```http://serverspeeder.azurewebsites.net/```        
(用Azure免费版搭建的,不支持```HTTPS```.)    
需要填写你机器网卡的MAC,点击OK就可以生成.         
也可以直接在服务器上运行下面这句(一般情况下可用):
```
wget -O apx.lic http://serverspeeder.azurewebsites.net/lic?mac=$(ifconfig |grep -B1 "$(wget -qO- ipv4.icanhazip.com)" |awk '/HWaddr/{ print $5 }')

```     
#仅供学习测试使用,严禁用于商业用途.
