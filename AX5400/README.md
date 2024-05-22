## [AX5400SSH步骤](https://github.com/mphin/miwifi_tools/blob/main/README.md#%E6%96%B0%E7%89%88ssh%E6%AD%A5%E9%AA%A4)
## AX5400固化步骤：
```
mkdir /data/auto_ssh && cd /data/auto_ssh
```
```
curl -O https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/AX5400/auto_ssh.sh
```
```
chmod +x auto_ssh.sh
```
```
./auto_ssh.sh install
```
## AX5400修改了/etc/rc.local开机启动脚本自动还原为空？  
解决办法：[通过防火墙添命令添加自启动脚本](https://github.com/mphin/miwifi_tools?tab=readme-ov-file#%E9%80%9A%E8%BF%87%E9%98%B2%E7%81%AB%E5%A2%99%E6%B7%BB%E5%8A%A0%E8%87%AA%E5%90%AF%E5%8A%A8%E8%84%9A%E6%9C%AC)  
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
curl -o /usr/libexec/sftp-server "https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/AX5400/sftp-server"
chmod 0755 /usr/libexec/sftp-server
```
最后将mount --bind /data/usr/libexec /usr/libexec按照上面的方法添加进开机启动脚本
## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。
