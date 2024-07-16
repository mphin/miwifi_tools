[Ax3600相关步骤](https://github.com/mphin/miwifi_tools/tree/main/ax3600/README.md)  
[Ax5400电竞版相关步骤](https://github.com/mphin/miwifi_tools/tree/main/ax5400_gaming/README.md)

[SSH默认密码计算](https://miwifi.dev/ssh)

## 新版SSH步骤(理论上 AX3000/AIoT AX3600/AX9000/万兆路由器/AC2100/AIoT AC2350/AX1800/AX5400 电竞版/红米 AX3000 几个型号)：
> 不含SSH固化  

windows电脑运行这条命令`cmd (conhost) / Git Bash / WSL` 不要直接CMD，然后替换下面的IP和stok，一条条执行，最后一条命令解锁SSH后在SSH执行，是修改路由器时间到当前时间，根据实际修改
```
curl -X GET "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/misystem/set_sys_time?time=2023-2-19%2023:4:47&timezone=CST-8"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(sed%20-i%20s%2Frelease%2FXXXXXX%2Fg%20%2Fetc%2Finit.d%2Fdropbear)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A1%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A1%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(nvram%20set%20ssh_en%3D1)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A2%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A2%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(nvram%20commit)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A3%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A3%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(%2Fetc%2Finit.d%2Fdropbear%20enable)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A4%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A4%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(%2Fetc%2Finit.d%2Fdropbear%20restart)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A5%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A5%22%2C%22week%22%3A0%7D"
```
获取SSH默认密码[MiWiFi SSH Password Calculator](https://miwifi.dev/ssh)    
然后在SSH执行：
```
date -s "2024-03-11 21:54:30"
```
> "2024-03-11 21:54:30"为当前时间，根据实际修改

#### ⚠️⚠️⚠️到此SSH开启成功，重启会失效，需固化SSH
## 静态路由防火墙配置：
开机会失效，需同时添加到在/etc/rc.local文件exit 0前追加   
> 例如：所有发送到192.168.2.0/24网络的数据包通过网关192.168.31.254进行转发
```
route add -net 192.168.2.0/24 gw 192.168.31.254
```
然后在/etc/config/firewall找到下面内容修改
```
config defaults
	option syn_flood '0'
	option input 'ACCEPT'
	option output 'ACCEPT'
	option forward 'REJECT'
	option drop_invalid '1'改为'0'
	option disable_ipv6 '1'

config zone
	option name 'lan'
	option network 'lan'
	option input 'ACCEPT'
	option output 'ACCEPT'
	option forward 'REJECT'改为'ACCEPT'
```
## 通过防火墙添加自启动脚本
> 用于/etc/rc.local文件无效的解决办法
```
curl -o /data "https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/startup_script.sh"
chmod +x /data/startup_script.sh
/data/startup_script.sh install
```
编辑/data/startup_script.sh文件查找下方修改为需要执行的开机启动命令
```
startup_script() {

        # Put your custom script here.
        echo "Starting custom scripts..."
}
```
> 注意：该防火墙脚本的执行顺序可能优于/etc/init.d/下的的脚本，因此针对某些特殊情况需延迟执行，例如：(sleep 20; xxx) &
## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。
