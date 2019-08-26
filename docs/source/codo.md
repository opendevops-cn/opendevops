### 项目前端

> 我们提供的有release包，建议直接下载release包更为方便！

**一、 直接下载资源包**

- 建议使用最新版本[Release](<https://github.com/opendevops-cn/codo/releases/>)

```
echo -e "\033[32m [INFO]: codo(项目前端) Start install. \033[0m"
CODO_VER="codo-beta-0.3.4"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
[ ! -d /var/www ] && mkdir -p /var/www
cd /var/www && wget https://github.com/opendevops-cn/codo/releases/download/${CODO_VER}/${CODO_VER}.tar.gz
tar zxf ${CODO_VER}.tar.gz
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: codo(项目前端) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(项目前端) install faild \033[0m"
    exit -8
fi
```

- 前端的静态文件会存放在`/var/www/codo/`目录内
- 测试一下 `ll /var/www/codo/index.html` 看下文件是不是存在

**后续访问使用API网关中的vhosts，节省资源，这里不单独安装配置nginx**