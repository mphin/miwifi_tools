## 此文件夹存放 [红米Ax5400普通版](https://www.mi.com/shop/buy/detail?product_id=15683) 相关文件


## 红米Ax5400普通版 安装SFTP
执行：
```
cp -rp /usr/libexec /data/usr/
mount --bind /data/usr/libexec /usr/libexec
curl -o /usr/libexec/sftp-server "https://fastly.jsdelivr.net/gh/mphin/miwifi_tools@main/ax5400/sftp-server"
chmod 0755 /usr/libexec/sftp-server
```
最后将mount --bind /data/usr/libexec /usr/libexec添加进[开机启动脚本](https://github.com/mphin/miwifi_tools?tab=readme-ov-file#%E9%80%9A%E8%BF%87%E9%98%B2%E7%81%AB%E5%A2%99%E6%B7%BB%E5%8A%A0%E8%87%AA%E5%90%AF%E5%8A%A8%E8%84%9A%E6%9C%AC)
## 声明

本项目中的所有步骤、文件以及相关信息均搜集自互联网，旨在提供学习和参考之用。我们尊重并遵循知识共享的原则，未经过原创作者许可的情况下，不会用于商业用途。如果您是原始内容的作者，且不希望您的作品出现在此项目中，请联系我们，我们将立即删除相关内容。我们感谢互联网上无数开放共享的资源，为我们提供了学习的机会。

