# Mi_Route_Tool
小米AX3600 小米AX5400电竞版 SSH相关工具备份  
[AX3600相关步骤](https://github.com/mphin/Mi_Route_Tool/tree/main/AX3600/README.md)  
[AX5400相关步骤](https://github.com/mphin/Mi_Route_Tool/tree/main/AX5400/README.md)
## 新版SSH步骤：
> 不含SSH固化  

`cmd (conhost) / Git Bash / WSL` windows电脑运行这条命令，不要直接CMD，然后替换下面的IP和stok，一条条执行，最后一条命令解锁SSH后在SSH执行，是修改路由器时间到当前时间，根据实际修改
```
curl -X GET "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/misystem/set_sys_time?time=2023-2-19%2023:4:47&timezone=CST-8"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(sed%20-i%20s%2Frelease%2FXXXXXX%2Fg%20%2Fetc%2Finit.d%2Fdropbear)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A1%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A1%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(nvram%20set%20ssh_en%3D1)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A2%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A2%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(nvram%20commit)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A3%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A3%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(%2Fetc%2Finit.d%2Fdropbear%20enable)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A4%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A4%22%2C%22week%22%3A0%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_setting%22%2C%22name%22%3A%22'%24(%2Fetc%2Finit.d%2Fdropbear%20restart)'%22%2C%22action_list%22%3A%5B%7B%22thirdParty%22%3A%22xmrouter%22%2C%22delay%22%3A17%2C%22type%22%3A%22wan_block%22%2C%22payload%22%3A%7B%22command%22%3A%22wan_block%22%2C%22mac%22%3A%2200%3A00%3A00%3A00%3A00%3A00%22%7D%7D%5D%2C%22launch%22%3A%7B%22timer%22%3A%7B%22time%22%3A%223%3A5%22%2C%22repeat%22%3A%220%22%2C%22enabled%22%3Atrue%7D%7D%7D"
```
```
curl -X POST "http://192.168.2.1/cgi-bin/luci/;stok=1417c7cb89733ba53b0b0934886caec0/api/xqsmarthome/request_smartcontroller" -d "payload=%7B%22command%22%3A%22scene_start_by_crontab%22%2C%22time%22%3A%223%3A5%22%2C%22week%22%3A0%7D"
```
> "2024-03-11 21:54:30"为当前时间，根据实际修改
```
date -s "2024-03-11 21:54:30"
```
## 静态路由防火墙配置：
开机会失效，需同时添加到在/etc/rc.local文件exit 0前追加
```
route add -net 192.168.2.0/24 gw 192.168.10.254
```
然后在/etc/config/firewall修改
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
	option forward 'REJECT'改为 'ACCEPT'
```
## 通过防火墙添加自启动脚本
> 用于/etc/rc.local文件无效的解决办法
```
curl -o /data "https://fastly.jsdelivr.net/gh/mphin/Mi_Route_Tool@main/startup_script.sh"
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
