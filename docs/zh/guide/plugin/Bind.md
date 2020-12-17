# DNS Bind

>opendevops平台所用组件[域名管理](https://github.com/opendevops-cn/codo-dns)Bind部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。

**安装配置**
```
yum install -y bind bind-chroot bind-utils
```

- 如果安装了bind-chroot（其中chroot是 change root 的缩写），BIND会被封装到一个伪根目录内，配置文件的位置变为：/var/named/chroot/etc/named.conf 　　
- BIND服务主配置文件/var/named/chroot/var/named/　　　　
- zone文件chroot是通过相关文件封装在一个伪根目录内，已达到安全防护的目的，一旦程序被攻破，将只能访问伪根目录内的内容，而不是真实的根目录

- BIND安装好之后不会有预制的配置文件，但是在BIND的文档文件夹内（/usr/share/doc/bind-9.9.4），BIND为我们提供了配置文件模板，我们可以直接拷贝过来：
```
# cp -r /usr/share/doc/bind-9.9.4/sample/etc/* /var/named/chroot/etc/
# cp -r /usr/share/doc/bind-9.9.4/sample/var/* /var/named/chroot/var/
```
- 配置BIND服务的主配置文件（/var/named/chroot/etc/named.conf，并加入zone参数
```
options {
        listen-on port 53       { 127.0.0.1; };
        listen-on-v6 port 53 { ::1; };
        allow-query     { any; };
        directory "/var/named";
        recursion yes;
        };

zone "ss.com"  {
        type master;
        file "ss.com.zone";
};
```
- 新建ss.com.zone文件 如下
```
# vim /var/named/chroot/var/named/ss.com.zone
$TTL 86400
$ORIGIN ss.com.
@  IN SOA  ss.com. admin.ss.com. (
                    20190426; serial #更新序列号
                    1D  ; refresh #更新时间
                    1H  ; retry #重试延时
                    1W  ; expire #失效时间
                    3H  ; minimum #无效解析记录的缓存时间
)
    IN  NS  ns1.ss.com.

ns1 3600 IN   A   192.168.99.99
www 3600 IN   A   172.20.66.110
ftp 3600 IN   A  10.128.105.250
```
- 禁用bind默认方式启动，改用bind-chroot方式启动。命令如下：
```
# /usr/libexec/setup-named-chroot.sh /var/named/chroot on
# systemctl stop named
# systemctl disable named
# systemctl start named-chroot
# systemctl enable named-chroot
```
- 检查语法
```
# named-checkzone ss.com /var/named/ss.com.zone
zone ss.com/IN: loaded serial 20190426
OK
# named-checkconf
```
- 查看是否启动，命令：
```
ps -ef|grep named
```
- 测试DNS服务，命令如下：
```
### 编辑dns解析文件 并写入你的DNS服务器地址
vim /etc/resolv.conf 
nameserver 172.16.0.111
dig ftp.ss.com
```

**参考文档**

[参考文档1](https://blog.csdn.net/bbwangj/article/details/82079405)

[参考文档2](https://blog.51cto.com/liqingbiao/2093064)

[参考文档3](https://blog.csdn.net/bpingchang/article/details/38377053)
