# LotServer

Install LotServer for Linux.

## Setup

```bash
bash appex.sh [install |unstall |install '{lotServer of Kernel Version}']
```

### Install

```bash
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/AndlsH/LotServer/master/appex.sh && chmod +x appex.sh && bash appex.sh install
```

Custom Install Example:

```bash
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/AndlsH/LotServer/master/appex.sh && chmod +x appex.sh && bash appex.sh install '3.10.0-229.1.2.el7.x86_64'
```

### Uninstall

```bash
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/AndlsH/LotServer/master/appex.sh && chmod +x appex.sh && bash appex.sh unstall
```

### Notice for Auto-start on CentOS 7

- Make a Systemd service [Recommanded]
```
# vi /lib/systemd/system/appex.service

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
```
- or, run:
```bash
chmod +x /etc/rc.d/rc.local
echo "/appex/bin/lotServer.sh start" >> /etc/rc.local
```


## Usage

### Start

```bash
/appex/bin/lotServer.sh start
```

### Status

```bash
/appex/bin/lotServer.sh status
```

### Stop

```bash
/appex/bin/lotServer.sh stop
```

### Deployment Manual [PDF]

- English
    ```
    http://download.appexnetworks.com/downloadlsManual.jsp
    ```
- Chinese
    ```
    http://download.appexnetworks.com.cn/downloadlsManual_cn.jsp
    ```
