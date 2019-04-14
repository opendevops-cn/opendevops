#! /bin/bash
# install docker and docker-compose
# By OpenDevOps  

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
