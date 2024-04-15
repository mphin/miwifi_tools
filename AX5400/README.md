## AX5400固化步骤：
```
mkdir /data/auto_ssh && cd /data/auto_ssh
```
```
curl -O https://fastly.jsdelivr.net/gh/mphin/Mi_Route_Tool@main/AX5400/auto_ssh.sh
```
```
chmod +x auto_ssh.sh
```
```
./auto_ssh.sh install
```
## AX5400修改了/etc/rc.local开机启动脚本自动还原为空？  
解决办法：通过防火墙添命令添加自启动脚本  
https://www.right.com.cn/forum/thread-8340357-1-1.html  
注意：如果没效果可能需要增加sleep增加延迟启动，比如添加路由表route add命令，我试过必须要添加sleep延迟才正常



## AX5400终端上下键没有历史记录功能？  
原因是/root目录只读且可用空间为0  
解决办法：利用/data目录可读写mkdir -p /data/root创建root文件夹，执行挂载命令
```
mount --bind /data/root /root
```
注意：开机会失效，按照上面的方法将mount --bind /data/root /root添加进开机启动脚本

## AX5400 SFTP连接不上？
原因是小米路由默认没有安装SFTP
解决办法：
```
cp -rp /usr/libexec /data/usr/
mount --bind /data/usr/libexec /usr/libexec
curl -o /usr/libexec/sftp-server "https://fastly.jsdelivr.net/gh/mphin/Mi_Route_Tool@main/AX5400/sftp-server"
chmod 0755 /usr/libexec/sftp-server
```
最后将mount --bind /data/usr/libexec /usr/libexec按照上面的方法添加进开机启动脚本
