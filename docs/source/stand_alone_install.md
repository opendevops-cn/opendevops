### 快速安装

> 快速部署将会提供脚本一键安装、Docker-compose一键部署，目前文档正在持续完善

**建议**
```
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                建议系统                    CentOS7
                建议配置                    2Core4G
                建议磁盘                    >=50G
             PS：请尽量使用纯净的CentOS7系统，我们会在服务器安装
    [python3.6、Node、Openresty、MySQL57、Redis3、Dnsmasq、Docker、RabbitMQ]
注意：一键部署不包含K8S组件模块，前端访问k8s相关会出现404错误，请无视，线上环境建议一步步分布式安装。
```

**脚本部署方式**
```
$ mkdir -p /opt/codo/ && cd /opt/codo/  #所有项目都放到/opt/codo/下
$ git clone https://github.com/opendevops-cn/opendevops.git
#修改环境变量文件env.sh,主要修改IP地址和域名信息，Token,Key可默认
#一键部署脚本，网络问题/其余问题可重试安装
$ cd opendevops && sh deploy.sh
```

**Docker-compose部署方式**
> 正在完善中。。。