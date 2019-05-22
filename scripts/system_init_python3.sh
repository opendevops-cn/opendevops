#! /bin/bash
# install python3.6
# By OpenDevOps  

echo -e "\033[32m [INFO]: Start install python3 \033[0m"
yum groupinstall Development tools -y
yum -y install zlib-devel
yum install -y python36-devel-3.6.3-7.el7.x86_64 openssl-devel libxslt-devel libxml2-devel libcurl-devel
cd /usr/local/src/
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

