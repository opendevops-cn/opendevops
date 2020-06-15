# 分布式部署

::: tip
基于全Docker的分布式部署方式。
:::


## 环境准备

### 建议配置

- 系统：  CentOS7+
- CPU：   4Core+
- 内存：  8G+
- 磁盘：  50G+



### 基础环境

- 依赖环境及工具
  - Docker
  - Docker-compose



### 优化系统(可选)

注意：

- 如果你的系统是新的，我们建议你先优化下系统，同样我们也提供了[优化系统脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts/system_init_v1.sh)
- 以下基础环境中，若你的系统中已经存在可跳过，直接配置，建议使用我们推荐的版本

### 关闭SELINUX

- 若已关闭请跳过
```shell
#临时关闭,立即生效。重启后会失效。
$ setenforce 0

#或修改配置文件关闭,需要重启
$ vi /etc/selinux/config  
将SELINUX=enforcing改为SELINUX=disabled 
```

### 清空防火墙规则

`注意，不要关闭防火墙，Docker需要用到NAT`

```shell
#只清空filter链即可
$ iptables -F
```



### 安装Python3

> 建议使用Python36,若你的系统里面已经存在Python36可以跳过此步骤。



### 安装docker  

> 若已安装可跳过

```shell
echo -e "\033[32m [INFO]: Start install docker,docker-compose \033[0m"
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum install -y docker-ce
#启动和开机自启
/bin/systemctl start docker.service
/bin/systemctl enable docker.service
```

**安装docker-compose编排工具**
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py 
#如果没有pip3 请安装
pip3 install docker-compose
```



## 获取env.sh文件

> 请到opendevops项目的ops/docker目录下获取最新的env.sh

此文件为整个项目中所有服务启动所需要的必要环境变量文件，如果没有特殊需要，只是想要快速体验熟悉项目，那么可以直接使用默认值即可。

如果是生产环境，建议修改文件中的相关服务账号密码及token，secret_key等变量值



## 获取docker-compose.yml文件

> 请到opendevops项目的ops/docker目录下获取最新的docker-compose文件，将该文件与上面的env.sh文件放置到同一目录下

如果修改了docker-compose文件中的服务的服务名称，那么需要修改env.sh文件对应的地址，否则可能会导致服务之间通讯有问题，因为目前所有服务之间的通讯均是基于服务名称解析后的ip来通讯



## 启动

```shell
docker-compose up -d
```



## 服务健康检测

```
# 测试前端服务状态
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://<service ip>:<service port>:80

# 测试API-GateWay服务状态
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://<service ip>:<service port>/api/accounts/are_you_ok/

# 其他服务进行检测，返回200则正常
# 请注意将域名修改为每个服务对应容器的ip地址和端口
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://<service ip>:<service port>/are_you_ok/
```



# 服务说明及注意事项

## 管理后端

`codo-admin`是基于tornado框架 restful风格的API 实现后台管理,[codo详细参考](https://github.com/opendevops-cn/codo-admin),搭配使用`codo`前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

> 注意：
>
> docker-compose中没有将AWS事件和WebTerminnal服务包含进去，如果有需要，可以自行集成到项目里

- AWS事件和WebTerminnal配置

> 首先将webterminal部署上去

```shell
docker pull webterminal/webterminallte
docker run -itd -p 8080:80 webterminal/webterminallte
```

`修改settings.py文件`

```shell

# Aws Events 事件邮件通知人
AWS_EVENT_TO_EMAIL = '1111@qq.com,2222@gmail.com'

#Web Terminal 地址，请填写你部署的webterminal地址
#注意这里是填写你上面docker run的机器外网IP
WEB_TERMINAL = 'http://1.1.1.1:8080'

```




## 定时任务

> CODO项目定时任务模块，定时任务完全兼容crontab，支持到秒级
>
> Docker部署需要将你的脚本目录单独挂载出来(目前docker-compose没有挂载出来，如果有需要，请自行修改docker-compose文件)，若不理解的同学参考：[codo-cron本地部署方式](https://bbs.opendevops.cn/topic/65/codo-cron-%E6%9C%AC%E5%9C%B0%E9%83%A8%E7%BD%B2%E6%96%B9%E5%BC%8F)




## 任务系统

> CODO任务系统，负责整个系统中任务调度，此功能是必须要安装的



## 运维工具

>CODO运维工具支持：告警管理、项目管理、事件管理、加密解密、随机密码、提醒管理等




## 域名管理

> CODO域名管理模块，管理BIND 支持智能解析，多域名，多主。



## API网关

> 由于此项目是模块化、微服务化，因此需要在借助API网关，需要在API网关注册，此步骤是必须的。


