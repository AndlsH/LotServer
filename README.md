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

### Uninstall
```bash
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/AndlsH/LotServer/master/appex.sh && chmod +x appex.sh && bash appex.sh unstall
```

### Custom Install
Example:
```bash
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeser_Install/master/appex.sh && chmod +x appex.sh && bash appex.sh install '3.10.0-229.1.2.el7.x86_64'
```

### Notice for CentOS 7
- Make a Systemd service
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