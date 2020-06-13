#! /bin/bash
# install node
# By OpenDevOps  

[ -f /usr/local/bin/node ] && echo "Node already exists" && exit -1
cd /usr/local/src && rm -rf node-v8.11.3-linux-x64.tar.xz
wget -q -c https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-x64.tar.xz
tar xf node-v8.11.3-linux-x64.tar.xz -C  /usr/local/ >/dev/null 2>&1
rm -rf /usr/local/bin/node
rm -rf /usr/local/bin/npm
ln -s /usr/local/node-v8.11.3-linux-x64/bin/node /usr/local/bin/node
ln -s /usr/local/node-v8.11.3-linux-x64/bin/node /usr/bin/node
ln -s /usr/local/node-v8.11.3-linux-x64/bin/npm  /usr/local/bin/npm
ln -s /usr/local/node-v8.11.3-linux-x64/bin/npm  /usr/bin/npm
/usr/local/bin/node -v
/usr/local/bin/npm -v
sudo npm i -g pm2 >/dev/null 2>&1
ln -s /usr/local/node-v8.11.3-linux-x64/bin/pm2 /usr/bin/





