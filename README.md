# Mi_Route_Tool
小米AX3600 小米AX5400电竞版 SSH相关工具备份

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
