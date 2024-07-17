## ⚙此文件夹存放 [小米AX3600](https://www.mi.com/pk/product/mi-aiot-router-ax3600) 相关文件步骤
[⬇️小米AX3600旧版本1.0.17版本下载](https://cdn.cnbj1.fds.api.mi-img.com/xiaoqiang/rom/r3600/miwifi_r3600_firmware_5da25_1.0.17.bin)（用于解锁SSH）  
  
    
[⬇️小米AX3600新版本1.1.24版本下载](https://kpan.mioffice.cn/webfolder/ext/JwtFMGj4vpg%40?n=0.9054722027079236)（解决iphone15pro系列手机连接5GWIFI导致的重启问题）
> 密码:<code>575w</code>
<details>
<summary><h3>👆︎旧版SSH步骤：</h3></summary>
<blockquote>
<p>⚠️需降级到1.0.17版本</p>
</blockquote>
<ol>
<li>
登录路由器后台在地址栏找到stok值，例如：
<pre><code>stok=8afbe612c65e43251e8a4dbff3cf67d1</code></pre>
stok=<code>&lt;STOK&gt;</code>替换成上面你提取到的 stok=<code>...</code> 以及下文所有192.168.31.1替换成你的路由器后台的IP
</li>
   
<li>
替换<code>&lt;STOK&gt;</code>浏览器打开：
<pre><code>http://192.168.31.1/cgi-bin/luci/;stok=&lt;STOK&gt;/api/misystem/set_config_iotdev?bssid=Xiaomi&user_id=longdike&ssid=-h%3B%20nvram%20set%20ssh_en%3D1%3B%20nvram%20commit%3B%20sed%20-i%20's%2Fchannel%3D.*%2Fchannel%3D%5C%22debug%5C%22%2Fg'%20%2Fetc%2Finit.d%2Fdropbear%3B%20%2Fetc%2Finit.d%2Fdropbear%20start%3B</code></pre>
</li>
<li>
替换<code>&lt;STOK&gt;</code>浏览器打开：
<pre><code>http://192.168.31.1/cgi-bin/luci/;stok=&lt;STOK&gt;/api/misystem/set_config_iotdev?bssid=Xiaomi&user_id=longdike&ssid=-h%3B%20echo%20-e%20'admin%5Cnadmin'%20%7C%20passwd%20root%3B</code></pre>
⚙SSH默认账号<code>root</code>密码<code>admin</code>
</li> 
<li>
SSH登录路由后执行备份mtd9分区命令：
<pre><code>mkdir /tmp/syslogbackup/</code></pre>
<pre><code>dd if=/dev/mtd9 of=/tmp/syslogbackup/mtd9</code></pre>
</li> 
<li>
浏览器请求该地址下载备份留存：
<pre><code>http://192.168.31.1/backup/log/mtd9</code></pre>
⚠️到此SSH开启步骤完成，重启会失效，需执行固化SSH
</li>

---
</ol>
</details>

<details>
<summary><h3>👆︎固化SSH步骤：</h3></summary>
<ol>
⚙SSH默认账号<code>root</code>密码<code>admin</code>
<li>
SSH登录路由后执行命令：
<pre><code>sed -i 's/18\.06-SNAPSHOT/18.06.0/g' /etc/opkg/distfeeds.conf</code></pre>
<pre><code>opkg install --force-overwrite wget unzip -d ram && /tmp/usr/bin/wget https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/ax3600/mitool.zip -O /data/mitool.zip && cd /data/ && /tmp/usr/bin/unzip /data/mitool.zip && /data/mitool_arm64 unlock</code></pre>
</li> 
<li>
重启路由后SSH执行命令：
<pre><code>/data/mitool_arm64 hack</code></pre>
会自动固化ssh和计算ssh默认密码并再次重启，复制password:后面的密码保存备用即可  
</li>

---
</ol>
</details>

<details>
<summary><h3>👆︎恢复SSH步骤：</h3></summary>
<blockquote>
<p>升级固件后会丢失SSH权限，所以需要恢复SSH</p>
</blockquote>
<ol>
<li>
电脑打开cmd执行命令：
<pre><code>telnet 192.168.31.1</code></pre>
输入你的SSH账号以及密码
</li>
<li>
登录成功后执行命令：
<pre><code>sed -i 's/channel=.*/channel="debug"/g' /etc/init.d/dropbear</code></pre>
<pre><code>/etc/init.d/dropbear start</code></pre>
</li>

---
</ol>
</details>

<details>
<summary><h3>👆︎安装SFTP：</h3></summary>
<ul>
<li>
方法一：直接使用opkg软件源安装：
<pre><code>opkg update</code></pre>
<pre><code>opkg install openssh-sftp-server</code></pre>
<blockquote>
<p>如报错尝试先执行sed -i 's/18\.06-SNAPSHOT/18.06.0/g' /etc/opkg/distfeeds.conf</p>
</blockquote>
</li>
<li>
方法二：手动下载二进制可执行文件安装：
<pre><code>curl -o /usr/libexec/sftp-server "https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/ax3600/sftp-server"</code></pre>
<pre><code>chmod 0755 /usr/libexec/sftp-server</code></pre>
</li>

---
</ul>
</details>

<details>
<summary><h3>👆︎扩容可写存储121MB：</h3></summary>
<blockquote>
<p>风险：请确认你的型号必须为小米AX3600，每一步必须按照步骤严格执行，参照正常输出，否则设备将会直接变砖</p>
</blockquote>
  
### 1.确认APPSBL分区
- 执行命令：
```
cat /proc/mtd
```
- 确认你的APPSBL分区是在/dev/mtd7
- 正常输出：
<pre>
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
</pre>
---
### 2.备份APPSBL
- 执行命令：
```
nanddump -f /tmp/APPSBL /dev/mtd7
```
- 手动将/tmp/APPSBL传回电脑备份
- 正常输出：
<pre>
root@XiaoQiang:~# nanddump -f /tmp/APPSBL /dev/mtd7
ECC failed: 0
ECC corrected: 0
Number of bad blocks: 0
Number of bbt blocks: 0
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x00000000 and ending at 0x00100000...
</pre>
---
### 3.导入APPSBL_signed
- [点击下载APPSBL_signed.zip](https://raw.githubusercontent.com/mphin/miwifi_tools/main/ax3600/APPSBL_signed.zip)
- 将新文件解压后APPSBL_signed传回/tmp目录
- 执行命令：
```
md5sum /tmp/APPSBL_signed
```
- 确认MD5是：41D91E1DC98E284086DFB17EBCB4B8EE
- 正常输出：
<pre>
root@XiaoQiang:~# md5sum /tmp/APPSBL_signed
41d91e1dc98e284086dfb17ebcb4b8ee  /tmp/APPSBL_signed
</pre>
---
### 4.刷入新的APPSBL
- 执行命令：
```
mtd write /tmp/APPSBL_signed /dev/mtd7
```
- 正常输出：
<pre>
root@XiaoQiang:~# mtd write /tmp/APPSBL_signed /dev/mtd7
Unlocking /dev/mtd7 ...

Writing from /tmp/APPSBL_signed to /dev/mtd7 ...
</pre>
---
### 5.重新读出确认md5
- 执行命令：
```
nanddump -f /tmp/APPSBL_cur /dev/mtd7
```
```
md5sum /tmp/APPSBL_cur
```
- 确认MD5是：0f0142b626067463e906b7f1d5903ef3
- 正常输出：
<pre>
root@XiaoQiang:~# md5sum /tmp/APPSBL_cur
0f0142b626067463e906b7f1d5903ef3  /tmp/APPSBL_cur
</pre>
---
### 6.重启
- 执行命令：
```
reboot
```
- 若可以正常重启并在此进入系统，则恭喜，全程风险最高步骤成功完成
---
### 7.确认uboot是否正常工作
- 上一步重启完后执行命令：
```
nvram set boot_wait=on
```
```
nvram set extrabootargs=uart_en=1
```
```
nvram get extrabootargs
```
- 确认返回值为uart_en=1
- 执行命令：
```
nvram commit
```
```
reboot
```
- 正常输出：
<pre>
root@XiaoQiang:~# nvram set boot_wait=on
root@XiaoQiang:~# nvram set extrabootargs=uart_en=1
root@XiaoQiang:~# nvram get extrabootargs
uart_en=1
root@XiaoQiang:~# nvram commit
root@XiaoQiang:~# reboot
</pre>
---
### 8.检查/proc/cmdline参数
- 上一步重启完后执行命令：
```
cat /proc/cmdline
```
- 查看是否出现了uart_en字样
- 正常输出：
<pre>
root@XiaoQiang:~# cat  /proc/cmdline
ubi.mtd=rootfs root=mtd:ubi_rootfs rootfstype=squashfs uart_en=1 rootwait swiotlb=1
</pre>
---
### 9.添加test分区
- 执行命令：
```
nvram set 'extrabootargs=mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
```
```
nvram get extrabootargs
```
- 正常输出：
<pre>
root@XiaoQiang:~# nvram get extrabootargs
mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
</pre>
---
### 10.检查test分区
- 执行命令：
```
nvram commit
```
```
reboot
```
- 正常输出：
<pre>
root@XiaoQiang:~# nvram get extrabootargs
mtdparts=qcom_nand.0:1m@1m(0:MIBIB),512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
root@XiaoQiang:~# reboot
</pre>
---
### 11.查看/proc/mtd
- 上一步重启完后执行命令：
```
cat /proc/mtd
```
- 查看是否在mtd7上出现了test分区
- 正常输出：
<pre>
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
</pre>
---
### 12.格式化建立ubi layer
- 执行命令：
```
ubiformat /dev/mtd7
```
- 正常输出：
<pre>
root@XiaoQiang:~# ubiformat /dev/mtd7
ubiformat: mtd7 (nand), size 150208512 bytes (143.2 MiB), 1146 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
libscan: scanning eraseblock 1145 -- 100 % complete
ubiformat: 1146 eraseblocks are supposedly empty
ubiformat: formatting eraseblock 1145 -- 100 % complete
</pre>
---
### 13.挂载ubi layer
- 执行命令：
```
ubiattach -p /dev/mtd7
```
- 正常输出：
<pre>
root@XiaoQiang:~# ubiattach -p /dev/mtd7
UBI device number 2, total 1146 LEBs (145514496 bytes, 138.7 MiB), available 1102 LEBs (139927552 bytes, 133.4 MiB), LEB size 126976 bytes (124.0 KiB)
</pre>
---
### 14.整个ubi layer分成一个rootfs_data分区
- 执行命令：
```
ubimkvol /dev/ubi2 -m -N rootfs_data
```
- 正常输出：
<pre>
root@XiaoQiang:~# ubimkvol /dev/ubi2 -m -N rootfs_data
Set volume size to 139927552
Volume ID 0, size 1102 LEBs (139927552 bytes, 133.4 MiB), LEB size 126976 bytes (124.0 KiB), dynamic, name "rootfs_data", alignment 1
</pre>
---
### 15.重新挂载文件系统
- 执行命令：
```
PREINIT=1 mount_root
```
```
mount
```
- 查看是否出现/overlay
- 正常输出：
<pre>
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
</pre>
---
### 16.自动挂载
- 执行命令：
```
nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
```
```
nvram get extrabootargs
```
- 正常输出：
<pre>
root@XiaoQiang:~# nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
root@XiaoQiang:~# nvram get extrabootargs
ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
</pre>
---
### 17.检查nvram挂载
- 执行命令：
```
nvram commit
```
```
reboot
```
- 正常输出：
<pre>
root@XiaoQiang:~# nvram set 'extrabootargs=ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)'
root@XiaoQiang:~# nvram get extrabootargs
ubi.mtd=overlay ubi.mtd=test mtdparts=qcom_nand.0:512k@6656k(0:APPSBLENV),512k@8m(0:ART),512k(bdata),36608k@10m(rootfs),36608k(rootfs_1),31488k(overlay),146688k@115456k(test)
root@XiaoQiang:~# reboot
</pre>
---
### 18.检查结果
- 上一步重启完后执行：
```
mount
```
- 重启后mount中仍然有overlay，则恭喜你，操作成功
- 正常输出：
<pre>
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
</pre>
---
## 取消扩容，恢复官方分区
- 执行命令：
```
nvram set extrabootargs=
```
```
nvram get extrabootargs
```
- 确认修改是否生效，执行命令：
```
nvram commit
```
```
reboot
```
- 上一步重启完后，上传好你先前备份的APPSBL到/tmp
- 切记上传完成后一定要校验MD5是否一致，Windows校验md5执行（powershell)命令：
```
Get-FileHash -Algorithm MD5 文件路径
```
- 确保上一步获取的MD5一致，路由器上执行校验md5命令：
```
md5sum 文件路径
```
- 执行命令：
```
mtd write /tmp/APPSBL /dev/mtd7
```
- 再次校验md5确保和刷入前是一致，执行命令：
```
nanddump -f /tmp/APPSBL /dev/mtd7
```
- 如果一致，执行重启命令：
```
reboot
```
重启完就恢复原来官方分区了

---
</details>

## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。
