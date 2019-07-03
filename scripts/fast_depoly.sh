#! /bin/bash
#By CODO CloudOpenDevOps
#Time: 2019-06-26
#只支持CentOS7+


usage() {
    echo "请按如下格式执行"
    echo "USAGE: bash $0 本机内网IP"
    echo "USAGE: bash $0 10.10.10.12"
    exit 1
}

#入口
if [ $# -lt 1 ]
then
    usage
fi

# 提示
echo -ne "\\033[0;33m"
cat<<EOT
                                  _oo0oo_
                                 088888880
                                 88" . "88
                                 (| -_- |)
                                  0\\ = /0
                               ___/'---'\\___
                             .' \\\\\\\\|     |// '.
                            / \\\\\\\\|||  :  |||// \\\\
                           /_ ||||| -:- |||||- \\\\
                          |   | \\\\\\\\\\\\  -  /// |   |
                          | \\_|  ''\\---/''  |_/ |
                          \\  .-\\__  '-'  __/-.  /
                        ___'. .'  /--.--\\  '. .'___
                     ."" '<  '.___\\_<|>_/___.' >'  "".
                    | | : '-  \\'.;'\\ _ /';.'/ - ' : | |
                    \\  \\ '_.   \\_ __\\ /__ _/   .-' /  /
                ====='-.____'.___ \\_____/___.-'____.-'=====
                                  '=---='


              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                建议系统                    CentOS7
                建议配置                    2Core4G
                建议磁盘                    >=50G
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
             PS：请尽量使用纯净的CentOS7系统，我们会在服务器安装
    [python3.6、Node、Openresty、MySQL57、Redis3、Dnsmasq、Docker、RabbitMQ]
注意：一键部署只是为了方便用户快速体验Beta0.3，MySQL/Redis/MQ等密码均在默认环境变量中。
注意，注意，注意， 此部署不可使用线上环境，线上推荐使用分布式安装/一步步安装！！！！



EOT
echo -ne "\\033[m"

read -s -n1 -p "按任意键继续 ... "



#定义一些函数
function check_ip() {
    IP=$1
    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        FIELD1=$(echo $IP|cut -d. -f1)
        FIELD2=$(echo $IP|cut -d. -f2)
        FIELD3=$(echo $IP|cut -d. -f3)
        FIELD4=$(echo $IP|cut -d. -f4)
        if [ $FIELD1 -le 255 -a $FIELD2 -le 255 -a $FIELD3 -le 255 -a $FIELD4 -le 255 ]; then
            echo "IP $IP available."
        else
            echo "IP $IP 校验失败,请确认拿下你的IP格式是不是合法的!"
        fi
    else
        echo "IP format error!"
    fi
}

function install_python3(){
  echo -e "\033[32m [INFO]: Start install python3 \033[0m"
  yum groupinstall Development tools -y
  yum -y install zlib-devel
  yum install -y python36-devel-3.6.3-7.el7.x86_64 openssl-devel libxslt-devel libxml2-devel libcurl-devel
  cd /usr/local/src/
  echo -e "\033[32m [INFO]: Start install python3 \033[0m"
  echo -e "\033[32m [INFO]: python3下载时间根据实际网络为准,请耐心等待。\033[0m"
  echo -e "\033[32m [INFO]: 这里并没有卡死，下载进度大小查看du -sh /usr/local/src/* \033[0m"
  wget -q -c https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
  tar xf  Python-3.6.4.tar.xz >/dev/null 2>&1 && cd Python-3.6.4
  ./configure >/dev/null 2>&1
  make >/dev/null 2>&1 && make install >/dev/null 2>&1
  if [ $? == 0 ];then
      echo -e "\033[32m [INFO]: python3 install success. \033[0m"
  else
      echo -e "\033[31m [ERROR]: python3 install faild \033[0m"
      exit -1
  fi
}



function install_docker_compose(){
  echo -e "\033[32m [INFO]: Start install docker,docker-compose \033[0m"
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum-config-manager --enable docker-ce-edge
  yum install -y docker-ce
  ###启动
  /bin/systemctl start docker.service
  ### 开机自启
  /bin/systemctl enable docker.service
  #安装docker-compose编排工具
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  pip3 install docker-compose
  if [ $? == 0 ];then
      echo -e "\033[32m [INFO]: docker-compose install success. \033[0m"
  else
      echo -e "\033[31m [ERROR]: docker-compose install faild \033[0m"
      exit -2
  fi
}


function init_env(){
#shell里面带EOFj居然不能空格/函数缩进也不行，会出语法错误
echo -e "\033[32m [INFO]: 开始设置ENV环境变量 \033[0m"
#创建环境变量
sudo tee /opt/codo/env.sh<<-'EOF'
#本机的IP地址
export LOCALHOST_IP="10.10.10.12"

#设置你的MYSQL密码
export MYSQL_PASSWORD="m9uSFL7duAVXfeAwGUSG"

### 设置你的redis密码
export REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"

### RabbitMQ用户密码信息
export MQ_USER="ss"
export MQ_PASSWORD="5Q2ajBHRT2lFJjnvaU0g"

### 管理后端地址
export mg_domain="mg.opendevops.cn"

### 定时任务地址,目前只启动一个进程，不用域名，直接IP即可
export cron_domain="10.10.10.12"

### 任务系统地址
export task_domain="task.opendevops.cn"

### CMDB系统地址
export cmdb_domain="cmdb2.opendevops.cn"

### 运维工具地址
export tools_domain="tools.opendevops.cn"


### 域名管理地址
export dns_domain="dns.opendevops.cn"


### 配置中心域名
export kerrigan_domain="kerrigan.opendevops.cn"

### 前端地址,也就是你的访问地址
export front_domain="demo.opendevops.cn"

### api网关地址
export api_gw_url="gw.opendevops.cn"


#codo-admin用到的cookie和token，可留默认
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
# 这里codo-admin和gw网关都会用到，一定要修改。可生成随意字符
export token_secret="pXFb4i%*834gfdh963df718iodGq4dsafsdadg7yI6ImF1999aaG7"


##如果要进行读写分离，Master-slave主从请自行建立，一般情况下都是只用一个数据库就可以了
# 写数据库
export DEFAULT_DB_DBHOST="10.10.10.12"
export DEFAULT_DB_DBPORT='3306'
export DEFAULT_DB_DBUSER='root'
export DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
#export DEFAULT_DB_DBNAME=${mysql_database}

# 读数据库
export READONLY_DB_DBHOST='10.10.10.12'
export READONLY_DB_DBPORT='3306'
export READONLY_DB_DBUSER='root'
export READONLY_DB_DBPWD=${MYSQL_PASSWORD}
#export READONLY_DB_DBNAME=${mysql_database}

# 消息队列
export DEFAULT_MQ_ADDR='10.10.10.12'
export DEFAULT_MQ_USER=${MQ_USER}
export DEFAULT_MQ_PWD=${MQ_PASSWORD}

# 缓存
export DEFAULT_REDIS_HOST='10.10.10.12'
export DEFAULT_REDIS_PORT=6379
export DEFAULT_REDIS_PASSWORD=${REDIS_PASSWORD}
EOF

sed  -i "s#10.10.10.12#$LOCAL_IP#g" env.sh
cat /opt/codo/env.sh
source /opt/codo/env.sh
}



function download_settings(){
  echo -e "\033[32m [INFO]: 开始下载个项目的配置文件 \033[0m"
  #下载配置文件
  #管理后端
  curl -o codo-admin-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-admin/master/settings.py

  #任务系统
  curl -o codo-task-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-task/master/settings.py

  #资产管理
  curl -o codo-cmdb-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-cmdb/master/settings.py

  #定时任务
  curl -o codo-cron-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-cron/master/settings.py

  #配置中心
  curl -o kerrigan-settings.py  https://raw.githubusercontent.com/opendevops-cn/kerrigan/master/settings.py

  #运维工具
  curl -o codo-tools-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-tools/master/settings.py

  #域名管理
  curl -o codo-dns-settings.py https://raw.githubusercontent.com/opendevops-cn/codo-dns/master/settings.py
}


function update_settings(){
  #修改settings配置
  #管理后端
  echo -e "\033[32m [INFO]: 开始修改各项目的配置文件 \033[0m"
  source /opt/codo/env.sh
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-admin-settings.py  
  sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" codo-admin-settings.py     
  DEFAULT_DB_DBNAME='codo_admin'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-admin-settings.py

  #任务系统
  TASK_DB_DBNAME='codo_task' 
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_ADDR = .*#DEFAULT_MQ_ADDR = os.getenv('DEFAULT_MQ_ADDR', '${DEFAULT_MQ_ADDR}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_USER = .*#DEFAULT_MQ_USER = os.getenv('DEFAULT_MQ_USER', '${DEFAULT_MQ_USER}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_PWD = .*#DEFAULT_MQ_PWD = os.getenv('DEFAULT_MQ_PWD', '${DEFAULT_MQ_PWD}')#g" codo-task-settings.py

  #资产管理
  CMDB_DB_DBNAME='codo_cmdb' 
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-cmdb-settings.py
  # 同步TAG树
  sed -i "s#CODO_TASK_DB_HOST = .*#CODO_TASK_DB_HOST = os.getenv('CODO_TASK_DB_HOST', '${DEFAULT_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_PORT = .*#CODO_TASK_DB_PORT = os.getenv('CODO_TASK_DB_PORT', '${DEFAULT_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_USER = .*#CODO_TASK_DB_USER = os.getenv('CODO_TASK_DB_USER', '${DEFAULT_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_PWD = .*#CODO_TASK_DB_PWD = os.getenv('CODO_TASK_DB_PWD', '${DEFAULT_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_DBNAME = .*#CODO_TASK_DB_DBNAME = os.getenv('CODO_TASK_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-cmdb-settings.py

  #定时任务
  CRON_DB_DBNAME='codo_cron' 
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-cron-settings.py

  #配置中心
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" kerrigan-settings.py 
  DEFAULT_DB_DBNAME='codo_kerrigan'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" kerrigan-settings.py

  #运维工具
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-tools-settings.py 
  DEFAULT_DB_DBNAME='codo_tools'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-tools-settings.py

  #域名管理
  CRON_DB_DBNAME='codo_dns' 
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-dns-settings.py

}


function mysql_database_file(){
      #数据库建库文件
echo -e "\033[32m [INFO]: 准备下创库语句，后面要用到 \033[0m"
sudo tee data.sql <<-'EOF'
create database codo_admin default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_task default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_cmdb default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_cron default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_kerrigan default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_tools default character set utf8mb4 collate utf8mb4_unicode_ci;
create database codo_dns default character set utf8mb4 collate utf8mb4_unicode_ci;
EOF
}


function docker_compose_file(){
#docker-compose
echo -e "\033[32m [INFO]: 准备多项目docker-compose文件 \033[0m"
source /opt/codo/env.sh
cd /opt/codo/
sudo tee docker-compose.yml <<-'EOF'
version: '3'
services:
  do_mg:
#for example:
#   build:
#     context: .
#     dockerfile: codo-admin.dockerfile
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-admin:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-admin-settings.py:/var/www/codo-admin/settings.py
    ports:
    - "8010:80"
    restart: unless-stopped
    networks: 
      - codo

  task:
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-task:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-task-settings.py:/var/www/codo-task/settings.py
      - /opt/ops_scripts:/opt/ops_scripts
    ports:
      - "8020:80"
    restart: unless-stopped
    networks:
      - codo

  cmdb:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-cmdb:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-cmdb-settings.py:/var/www/codo-cmdb/settings.py
    ports:
    - "8050:80"
    hostname: codo-cmdb
    networks:
      - codo

  cron:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-cron:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /opt/ops_scripts:/opt/ops_scripts
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-cron-settings.py:/var/www/codo-cron/settings.py
    ports:
      - "9900:9900"
    networks:
      - codo

  kerrigan:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/opendevops/kerrigan:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /opt/ops_scripts:/opt/ops_scripts
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./kerrigan-settings.py:/var/www/kerrigan/settings.py
    ports:
      - "8030:80"
    networks:
      - codo

  tools:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-tools:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-tools-settings.py:/var/www/codo-tools/settings.py
    ports:
      - "8040:80"
    hostname: codo-tools
    networks:
      - codo

  dns:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/opendevops/codo-dns:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /opt/ops_scripts:/opt/ops_scripts
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-dns-settings.py:/var/www/codo-dns/settings.py
    ports:
      - "8060:80"
    networks:
      - codo

  redis:
    image: redis:4
    ports:
      - 6379:6379
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD}
    networks:
      - codo

  mysql:
    restart: unless-stopped
    image: mysql:5.7
    volumes:
      - ./data.sql:/docker-entrypoint-initdb.d/data.sql
      - /data/mysql:/var/lib/mysql
      - /data/mysql_conf:/etc/mysql/conf.d
    ports:
    - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}
    networks:
      - codo

  rabbitmq:
    restart: unless-stopped
    image: rabbitmq:3-management
    environment:
      - RABBITMQ_DEFAULT_USER=${MQ_USER}
      - RABBITMQ_DEFAULT_PASS=${MQ_PASSWORD}
    ports:
      - "15672:15672"
      - "5672:5672"
    networks:
      - codo 
networks:
    codo:
EOF
}

function docker_compose_up(){
  echo -e "\033[32m [INFO]: docker-compose同时启动多项目 \033[0m"
  source /opt/codo/env.sh
  cd /opt/codo/
  exist_codo_docker_num=`docker ps -a |grep -E "codo-admin|codo-tools|codo-cmdb|codo-dns|codo-task|kerrigan" | wc -l`

  if [[ ${exist_codo_docker_num} -gt 0 ]]; then
    docker-compose down ; docker-compose up -d
  else
    cd /opt/codo/
    docker-compose up -d
    if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: DockerCompose启动完成. \033[0m"; else echo -e "\033[31m [ERROR]: DockerCompose启动失败 \033[0m" && exit -6; fi
  fi
}

function init_mysql(){
  echo -e "\033[32m [INFO]: 开始初始化各项目的数据 \033[0m"

  #初始化数据库（注：由于上一步操作同一时间启动复数容器，在执行以下命令时可能会提示无法连接mysql，可稍等片刻再尝试）
  echo -e "\033[32m [INFO]: 这里请耐心等待30s，等待MySQL启动成功，不然会导致连不上数据库 \033[0m"
  sleep 30s
  iptables -F
  exist_codo_docker_num=`docker ps -a |grep -E "codo-admin|codo-tools|codo-cmdb|codo-dns|codo-task|kerrigan" | wc -l`
  if [[ ${exist_codo_docker_num} -ne 6 ]]; then
    echo -e "\033[31m [ERROR]: 没有发现COOD项目Docker服务是启动的，请检查是否启动成功了 \033[0m"
  fi
  docker exec -ti codo_do_mg_1  /usr/local/bin/python3 /var/www/codo-admin/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-admin 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-admin 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti codo_task_1  /usr/local/bin/python3 /var/www/codo-task/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-task 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-task 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti codo_cmdb_1 /usr/local/bin/python3 /var/www/codo-cmdb/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-cmdb 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-admin 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti codo_cron_1  /usr/local/bin/python3 /var/www/codo-cron/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-cron 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-cron 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti  codo_kerrigan_1  /usr/local/bin/python3 /var/www/kerrigan/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-kerrigan 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-kerrigan 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti  codo_tools_1  /usr/local/bin/python3 /var/www/codo-tools/db_sync.py 
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-tools 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-tools 数据库初始化失败 \033[0m" && exit -6; fi
  docker exec -ti codo_dns_1 /usr/local/bin/python3 /var/www/codo-dns/db_sync.py
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: codo-dns 数据库初始化完成. \033[0m"; else echo -e "\033[31m [ERROR]: codo-dns 数据库初始化失败 \033[0m" && exit -6; fi
  cd /opt/codo/
  source /opt/codo/env.sh
  curl -O https://raw.githubusercontent.com/opendevops-cn/codo-admin/master/doc/codo_admin_beta0.3.sql
  [ ! -f /usr/bin/mysql ] && yum install mysql -y
  check_admin_user_num=`mysql -h${DEFAULT_DB_DBHOST} -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} codo_admin -e "select username from mg_users where username='admin';" | wc -l`
  if [ ${check_admin_user_num} -eq 0 ]; then mysql -h${DEFAULT_DB_DBHOST} -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} codo_admin < ./codo_admin_beta0.3.sql; else echo "初始化用户已存在" ; fi
  if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: 导入codo-admin用户权限数据完成. \033[0m"; else echo -e "\033[31m [ERROR]: 导入codo-admin用户权限数据完成失败 \033[0m" && exit -6; fi
}


function install_dnsmasq(){
echo -e "\033[32m [INFO]: 部署dnsmasql内部通信服务 \033[0m"
source /opt/codo/env.sh
yum install dnsmasq -y
# 设置上游DNS，毕竟你的Dns只是个代理
sudo tee /etc/resolv.dnsmasq <<-'EOF'
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

#设置host解析，这里同学注意一下子，如果你是单机部署，那么你就将你的本机IP+模块域名解析即可，
#如果你是分布式部署的，那么每个模块对应的机器IP一定不要搞错，这个很重要，后面网关也要依赖此DNS去解析你的域名，帮你做服务转发的，切记！！！！
sudo tee /etc/dnsmasqhosts <<-EOF
$LOCALHOST_IP $front_domain
$LOCALHOST_IP $mg_domain
$LOCALHOST_IP $task_domain
$LOCALHOST_IP $api_gw_url
$LOCALHOST_IP $cmdb_domain
$LOCALHOST_IP $kerrigan_domain
$LOCALHOST_IP $tools_domain
$LOCALHOST_IP $dns_domain
EOF

#添加配置
#注意：
 # 刚装完DNS可以先不用改本机的DNS，有一部分人反应Docker Build时候会报连不上mirrors，装不了依赖。
 # 部署到API网关的时候，需要将本机DNS改成自己，不然没办法访问以上mg.cron,cmdb等内网域名
echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf   
echo "resolv-file=/etc/resolv.dnsmasq" >> /etc/dnsmasq.conf
echo "addn-hosts=/etc/dnsmasqhosts" >> /etc/dnsmasq.conf

## 启动
/bin/systemctl start dnsmasq.service
/bin/systemctl enable dnsmasq.service
systemctl status dnsmasq
/bin/systemctl restart dnsmasq.service

if [ $? == 0 ];then
  echo -e "\033[32m [INFO]: dnsmasq install success. \033[0m"
else
  echo -e "\033[31m [ERROR]: dnsmasq install faild \033[0m"
  exit -6
fi
}


function install_codo(){
  #安装前端

  echo -e "\033[32m [INFO]: codo(项目前端) Start install. \033[0m"
  source /opt/codo/env.sh
  CODO_VER="codo-beta-0.3.2"
  rm -rf /var/www/codo-*
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
}


function install_api_gw(){
echo -e "\033[32m [INFO]: API网关 Start install. \033[0m"
source /opt/codo/env.sh
#安装openresty
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/
sudo tee /usr/local/openresty/nginx/conf/nginx.conf <<-'EOF'
user root;
worker_processes auto;
worker_rlimit_nofile 51200;
error_log logs/error.log;
events {
    use epoll;
    worker_connections 51024;
}
http {
    #设置默认lua搜索路径
    lua_package_path '$prefix/lua/?.lua;/blah/?.lua;;';
    lua_code_cache on;      #线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;    #代理静态文件

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;

    init_by_lua_file lua/init_by_lua.lua;       # nginx启动时就会执行
    include ./conf.d/*.conf;                    # lua生成upstream
    resolver 10.10.10.12;                       # 内部DNS服务器地址
}
EOF
source /opt/codo/env.sh
sed  -i "s#10.10.10.12#$LOCALHOST_IP#g" /usr/local/openresty/nginx/conf/nginx.conf
sudo tee /usr/local/openresty/nginx/conf/conf.d/gw.conf <<-'EOF'
server {
    listen 80;
    server_name gw.opendevops.cn;
    lua_need_request_body on;           # 开启获取body数据记录日志

    location / {
        ### ws 支持
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        ### 获取真实IP
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        access_by_lua_file lua/access_check.lua;
        set $my_upstream $my_upstream;
        proxy_pass http://$my_upstream;

        ### 跨域
        add_header Access-Control-Allow-Methods *;
        add_header Access-Control-Max-Age 3600;
        add_header Access-Control-Allow-Credentials true;
        add_header Access-Control-Allow-Origin $http_origin;
        add_header Access-Control-Allow-Headers $http_access_control_request_headers;
        if ($request_method = OPTIONS){
            return 204;}
    }
}
EOF
mkdir -p /usr/local/openresty/nginx/conf/conf.d/
sudo tee /usr/local/openresty/nginx/conf/conf.d/demo.conf <<-'EOF'
server {
        listen       80;
        server_name demo.opendevops.cn;
        access_log /var/log/nginx/f_access.log;
        error_log  /var/log/nginx/f_error.log;
        root /var/www/codo;

        location / {
                    root /var/www/codo;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
                    }

        location /api {
                ### ws 支持
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}
EOF
source /opt/codo/env.sh
sudo tee /usr/local/openresty/nginx/lua/configs.lua <<-EOF
json = require("cjson")

--mysql_config = {
--    host = "127.0.0.1",
--    port = 3306,
--    database = "lua",
--    user = "root",
--    password = "",
--    max_packet_size = 1024 * 1024
--}

-- redis配置，一定要修改,并且和codo-admin保持一致
redis_config = {
    host = '${DEFAULT_REDIS_HOST}',
    port = '${DEFAULT_REDIS_PORT}',
    auth_pwd = '${DEFAULT_REDIS_PASSWORD}',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}


-- 注意：这里的token_secret必须要和codo-admin里面的token_secret保持一致
token_secret = '${token_secret}'
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://mg.opendevops.cn:8010/v2/accounts/verify/'
-- 注意：rewrite_cache_token要和codo-admin里面的secret_key = '8b888a62-3edb-4920-b446-697a472b4001'保持一致
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'  


--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则,API网关域名
gw_domain_name = 'gw.opendevops.cn' 

--下面的转发一定要修改，根据自己实际数据修改
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/dns",
                rewrite_upstream = "dns.opendevops.cn:8060"
            },
            {
                uri = "/cmdb2",
                rewrite_upstream = "cmdb2.opendevops.cn:8050"
            },
            {
                uri = "/tools",
                rewrite_upstream = "tools.opendevops.cn:8040"
            },
            {
                uri = "/kerrigan",
                rewrite_upstream = "kerrigan.opendevops.cn:8030"
            },
            {
                uri = "/cmdb",
                rewrite_upstream = "cmdb.opendevops.cn:8002"
            },
            {
                uri = "/k8s",
                rewrite_upstream = "k8s.opendevops.cn:8001"
            },
            {
                uri = "/task",
                rewrite_upstream = "task.opendevops.cn:8020"
            },
            {
                uri = "/cron",
                rewrite_upstream = "10.2.2.236:9900"
            },
            {
                uri = "/mg",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
        }
    }
}
EOF
mkdir -p /var/log/nginx/ && touch /var/log/nginx/f_access.log
openresty -t   #测试
systemctl start openresty
systemctl enable openresty
systemctl status openresty
if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: 网关部署完成. \033[0m"; else echo -e "\033[31m [ERROR]: 网关部署完成失败 \033[0m" && exit -6; fi
}

#定义函数结束


#入口逻辑

#创建目录
[ ! -d /opt/codo ] && mkdir -p /opt/codo
cd /opt/codo/

#校验IP
LOCAL_IP=$1
check_ip $LOCAL_IP
[ $? != 0 ] && echo "请输入格式正确的内网IP" && exit -1

# 基础环境python3/docker/docker-compose--> 初始化env--> 下载项目配置--> 修改项目配置--> 创库语句--> 多项目docker-compose--> docker-compose启动多项目--> 初始化多项目数据--> 部署DNS内部通信--> 部署前端--> 部署网关--> 访问

export -f install_python3
export -f install_docker_compose
export -f init_env
export -f download_settings
export -f update_settings
export -f mysql_database_file
export -f docker_compose_file
export -f docker_compose_up
export -f init_mysql
export -f install_dnsmasq
export -f install_codo
export -f install_api_gw


[ -f /usr/local/bin/python3 ] && echo -e "\033[33m [Warning]: Python3 already exists,Skip installation \033[0m"  || install_python3
[ -f /usr/local/bin/docker-compose ] && echo -e "\033[33m [Warning]: Docker-compose already exists,Skip installation \033[0m"  || install_docker_compose
init_env && download_settings && update_settings && mysql_database_file && docker_compose_file && docker_compose_up && init_mysql && install_dnsmasq
[ -f /var/www/codo/index.html ] && echo -e "\033[33m [Warning]: 项目前端:/var/www/codo/ already exists,Skip installation \033[0m"  || install_codo
install_api_gw
echo -e "\033[32m [INFO]: 你的访问地址：http://demo.opendevops.cn  \033[0m"
echo -e "\033[32m [INFO]: 你的访问用户：admin  \033[0m"
echo -e "\033[32m [INFO]: 你的访问密码：admin@opendevops  \033[0m"
echo -e "\033[32m [INFO]: 请在你的PC机器上绑定本地Host进行登陆测试  \033[0m"
echo -e "\033[32m [INFO]: 你的MySQL/Redis/MQ等密码请在/opt/codo/env.sh找到  \033[0m"
echo -e "\033[32m [INFO]: 日志目录：/var/log/supervisor/, 详细可查看日志log是否有报错。 \033[0m"

