### 管理后端

`codo-admin`是基于tornado框架 restful风格的API 实现后台管理,[codo详细参考](https://github.com/opendevops-cn/codo-admin),搭配使用`codo`前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

**获取代码**
```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-admin.git && cd codo-admin
```
**确认数据库信息**
```shell
#数据库data.sql一键初始化，数据库名字：codo_admin 可登陆确认是否有数据，没有请导入data.sql
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}
```
**修改相关配置**
```shell
DEFAULT_DB_DBNAME='codo_admin'   #项目后端数据库

#进程数量,配置文件自行修改
#修改配置，cookie_secret和token_secret 请自行生成复杂token,key 更改env.sh文件
source env.sh   #环境变量文件
sed -i  "s#server_name .*#server_name ${mg_domain};#g" doc/nginx_ops.conf   #管理后端域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py  #Tornado使用cookie_secret
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py     #Token
mysql配置
PS：codo-admin项目支持取env环境变量，但是还是建议修改下。
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py

#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py
#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py
#删除没必要的目录映射，这里调试的时候给目录映射出来了，后续会直接给这条映射直接删除掉。
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml

```

**编译镜像，启动**
```shell
#bulid 镜像
docker build . -t do_mg_image
#启动
docker-compose up -d
```


**测试codo-admin**
```shell
### 01.日志
tailf  /var/log/supervisor/mg.log  #确认没有报错

### 02. 提供AreYouOK接口
mg_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$mg_domain:8010/are_you_ok/`

if [ $mg_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(项目后端) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(项目后端) install faild \033[0m"
    exit -9
fi
```

