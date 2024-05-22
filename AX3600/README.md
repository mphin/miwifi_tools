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
opkg install --force-overwrite wget unzip -d ram && /tmp/usr/bin/wget https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/AX3600/mitool.zip -O /data/mitool.zip && cd /data/ && /tmp/usr/bin/unzip /data/mitool.zip && /data/mitool_arm64 unlock
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
> 如报错尝试执行该命令sed -i 's/18\.06-SNAPSHOT/18.06.0/g' /etc/opkg/distfeeds.conf
```
opkg update
opkg install openssh-sftp-server
```
## AX3600_扩容解锁未使用NAND空间，获得可写rootfs
> 风险：每一步必须按照步骤严格执行，参照正常输出，否则设备将会直接变砖
### 1.确认APPSBL分区
- 执行
```
cat /proc/mtd
```
- 确认你的APPSBL分区是在/dev/mtd7
- 正常输出：
```
root@XiaoQiang:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00100000 00020000 "0:SBL1"
mtd1: 00100000 00020000 "0:MIBIB"
mtd2: 00300000 00020000 "0:QSEE"
mtd3: 00080000 00020000 "0:DEVCFG"
mtd4: 00080000 00020000 "0:RPM"
mtd5: 00080000 00020000 "0:CDT"
mtd6: 00080000 00020000 "0:APPSBLENV"
mtd7: 00100000 00020000 "0:APPSBL"
mtd8: 00080000 00020000 "0:ART"
mtd9: 00080000 00020000 "bdata"
mtd10: 00080000 00020000 "crash"
mtd11: 00080000 00020000 "crash_syslog"
mtd12: 023c0000 00020000 "rootfs"
mtd13: 023c0000 00020000 "rootfs_1"
mtd14: 01ec0000 00020000 "overlay"
mtd15: 00080000 00020000 "rsvd0"
mtd16: 0041e000 0001f000 "kernel"
mtd17: 0160a000 0001f000 "ubi_rootfs"
mtd18: 01876000 0001f000 "data"
```
---
### 2.备份APPSBL
- 执行
```
nanddump -f /tmp/APPSBL /dev/mtd7
```
- 手动将/tmp/APPSBL传回电脑备份
- 正常输出：
```
root@XiaoQiang:~# nanddump -f /tmp/APPSBL /dev/mtd7
ECC failed: 0
ECC corrected: 0
Number of bad blocks: 0
Number of bbt blocks: 0
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x00000000 and ending at 0x00100000...
```
---
### 3.导入APPSBL_signed
- [点击下载](https://raw.githubusercontent.com/mphin/miwifi_tools/main/AX3600/APPSBL_signed.zip)
- 将新文件解压后APPSBL_signed传回/tmp目录
- 执行
```
md5sum /tmp/APPSBL_signed
```
- 确认MD5是：41D91E1DC98E284086DFB17EBCB4B8EE
- 正常输出：
```
root@XiaoQiang:~# md5sum /tmp/APPSBL_signed
41d91e1dc98e284086dfb17ebcb4b8ee  /tmp/APPSBL_signed
```
---
### 4.刷入新的APPSBL
- 执行
```
mtd write /tmp/APPSBL_signed /dev/mtd7
```
- 刷入新的APPSBL
- 正常输出：
```
root@XiaoQiang:~# mtd write /tmp/APPSBL_signed /dev/mtd7
Unlocking /dev/mtd7 ...

Writing from /tmp/APPSBL_signed to /dev/mtd7 ...
```
---
### 5.重新读出确认md5
- 执行
```
nanddump -f /tmp/APPSBL_cur /dev/mtd7
md5sum /tmp/APPSBL_cur
```
- 确认MD5是：0f0142b626067463e906b7f1d5903ef3
- 正常输出：
```
root@XiaoQiang:~# md5sum /tmp/APPSBL_cur
0f0142b626067463e906b7f1d5903ef3  /tmp/APPSBL_cur
```
---
### 6.重启
- 执行
```
reboot
```
- 若可以正常重启并在此进入系统，则恭喜，全程风险最高步骤成功完成
---
### 7.确认uboot是否正常工作
- 执行
```
nvram set boot_wait=on
nvram set extrabootargs=uart_en=1
nvram get extrabootargs
```
- 确认返回值为uart_en=1
- 执行
```
nvram commit
reboot
```
- 重启
- 正常输出：
```
root@XiaoQiang:~# nvram set boot_wait=on
root@XiaoQiang:~# nvram set extrabootargs=uart_en=1
root@XiaoQiang:~# nvram get extrabootargs
uart_en=1
root@XiaoQiang:~# nvram commit
root@XiaoQiang:~# reboot
```
---
### 8.检查/proc/cmdline参数
- 执行
```
cat /proc/cmdline
```
- 查看是否出现了uart_en字样
- 正常输出：
```
root@XiaoQiang:~# cat  /proc/cmdline
ubi.mtd=rootfs root=mtd:ubi_rootfs rootfstype=squashfs uart_en=1 rootwait swiotlb=1
```
---
### 9.添加test分区
- 执行
```
nvram set 'extrabootargs=mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
nvram get extrabootargs
```
- 正常输出：
```
root@XiaoQiang:~# nvram get extrabootargs
mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
```
---
### 10.检查test分区
- 执行
```
nvram commit
reboot
```
- 重启
- 正常输出：
```
root@XiaoQiang:~# nvram get extrabootargs
mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
root@XiaoQiang:~# reboot
```
---
### 11.查看/proc/mtd
- 执行
```
cat /proc/mtd
```
- 查看是否在mtd7上出现了test分区
- 正常输出：
```
root@XiaoQiang:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00100000 00020000 "0:MIBIB"
mtd1: 00080000 00020000 "0:APPSBLENV"
mtd2: 00080000 00020000 "0:ART"
mtd3: 00080000 00020000 "bdata"
mtd4: 023c0000 00020000 "rootfs"
mtd5: 023c0000 00020000 "rootfs_1"
mtd6: 01ec0000 00020000 "overlay"
mtd7: 08f40000 00020000 "test"
mtd8: 0041e000 0001f000 "kernel"
mtd9: 0160a000 0001f000 "ubi_rootfs"
mtd10: 01876000 0001f000 "data"
```
---
### 12.格式化建立ubi layer
- 执行
```
ubiformat /dev/mtd7
```
- 正常输出：
```
root@XiaoQiang:~# ubiformat /dev/mtd7
ubiformat: mtd7 (nand), size 150208512 bytes (143.2 MiB), 1146 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
libscan: scanning eraseblock 1145 -- 100 % complete
ubiformat: 1146 eraseblocks are supposedly empty
ubiformat: formatting eraseblock 1145 -- 100 % complete
```
---
### 13.挂载ubi layer
- 执行
```
ubiattach -p /dev/mtd7
```
- 正常输出：
```
root@XiaoQiang:~# ubiattach -p /dev/mtd7
UBI device number 2, total 1146 LEBs (145514496 bytes, 138.7 MiB), available 1102 LEBs (139927552 bytes, 133.4 MiB), LEB size 126976 bytes (124.0 KiB)
```
---
### 14.整个ubi layer分成一个rootfs_data分区
- 执行
```
ubimkvol /dev/ubi2 -m -N rootfs_data
```
- 正常输出：
```
root@XiaoQiang:~# ubimkvol /dev/ubi2 -m -N rootfs_data
Set volume size to 139927552
Volume ID 0, size 1102 LEBs (139927552 bytes, 133.4 MiB), LEB size 126976 bytes (124.0 KiB), dynamic, name "rootfs_data", alignment 1
```
---
### 15.重新挂载文件系统
- 执行
```
PREINIT=1 mount_root
mount
```
- 查看是否出现/overlay
- 正常输出：
```
root@XiaoQiang:~# mount
mtd:ubi_rootfs on /rom type squashfs (ro,noatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
cgroup on /sys/fs/cgroup type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset,cpu,cpuacct,blkio,memory,devices,freezer,net_cls,pids)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)
ubi1_0 on /rom/data type ubifs (rw,relatime)
ubi1_0 on /rom/userdisk type ubifs (rw,relatime)
mtd:ubi_rootfs on /rom/userdisk/data type squashfs (ro,noatime)
ubi1_0 on /rom/etc type ubifs (rw,relatime)
ubi1_0 on /rom/ini type ubifs (rw,relatime)
tmpfs on /dev type tmpfs (rw,nosuid,relatime,size=512k,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,mode=600,ptmxmode=000)
debugfs on /sys/kernel/debug type debugfs (rw,noatime)
/dev/ubi2_0 on /overlay type ubifs (rw,noatime)
overlayfs:/overlay on / type overlay (rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work)
```
---
### 16.自动挂载
- 执行
```
nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
nvram get extrabootargs
```
- 正常输出：
```
root@XiaoQiang:~# nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
root@XiaoQiang:~# nvram get extrabootargs
ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
```
---
### 17.检查nvram挂载
- 执行
```
nvram commit
reboot
```
- 重启
- 正常输出：
```
root@XiaoQiang:~# nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
root@XiaoQiang:~# nvram get extrabootargs
ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
root@XiaoQiang:~# reboot
```
---
### 18.检查结果
- 执行
```
mount
```
- 重启后mount中仍然有overlay，则恭喜你，操作成功
- 正常输出：
```
root@XiaoQiang:~# mount
mtd:ubi_rootfs on /rom type squashfs (ro,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
cgroup on /sys/fs/cgroup type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset,cpu,cpuacct,blkio,memory,devices,freezer,net_cls,pids)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)
/dev/ubi2_0 on /overlay type ubifs (rw,noatime)
overlayfs:/overlay on / type overlay (rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work)
ubi1_0 on /data type ubifs (rw,relatime)
ubi1_0 on /userdisk type ubifs (rw,relatime)
overlayfs:/overlay on /userdisk/data type overlay (rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work)
ubi1_0 on /etc type ubifs (rw,relatime)
ubi1_0 on /ini type ubifs (rw,relatime)
tmpfs on /dev type tmpfs (rw,nosuid,relatime,size=512k,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,mode=600,ptmxmode=000)
debugfs on /sys/kernel/debug type debugfs (rw,noatime)
```
## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。
