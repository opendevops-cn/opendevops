## 版本更新

> 主要介绍下前后端都是如何进行版本更新的


### 前端更新
> 由于前端都是静态文件，更新起来非常简单，直接下载最新的[release](https://github.com/opendevops-cn/codo/releases)包解压即可

```
rm -rf /var/www/codo/
CODO_VER="codo-beta-0.3.2"   #这里改为最新的relase版本
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
[ ! -d /var/www ] && mkdir -p /var/www
cd /var/www && wget https://github.com/opendevops-cn/codo/releases/download/${CODO_VER}/${CODO_VER}.tar.gz
tar zxf ${CODO_VER}.tar.gz
```

### 后端更新

> 后端都是微服务的，更新某个模块只需要对单个模块操作即可


- 举个例子，没有修改表结构的更新
```shell
# 进到你的模块目录
cd /opt/codo/codo-cmdb  

#先给你自己的settings备份下，省的频繁修改
mv settings.py settings.py-bak    

#获取最新代码
git pull  

#覆盖回来
mv settings.py-bak settings.py    

 #重新打包镜像
docker build . -t codo_cmdb    

#compose启动
docker-compose up -d            

#查看日志是否有错误
tailf /var/log/supervisor/cmdb.log  

```

- 假如后端修改了表结构我怎么更新呢？

> 如果后端修改了表结构，我们的更新文档都会说明哪些需要`ALTER TABLE`,比如CMDB资产配置新增了华为云的支持，

- 问题1：我不想重新初始化，里面有数据，想直接改表结构  

```mysql  

#先进到你的数据库，每个模块都是对应一个版本库的

ALTER TABLE `asset_configs` ADD `project_id` VARCHAR(120) NOT NULL ;
ALTER TABLE `asset_configs` ADD `huawei_cloud` VARCHAR(120) NOT NULL ;
ALTER TABLE `asset_configs` ADD `huawei_instance_id` VARCHAR(120) NOT NULL ;  

```
- 然后更新你的代码

```shell
# 进到你的模块目录
cd /opt/codo/codo-cmdb  

#先给你自己的settings备份下，省的频繁修改
mv settings.py settings.py-bak    

#获取最新代码
git pull  

#覆盖回来
mv settings.py-bak settings.py    

 #重新打包镜像
docker build . -t codo_cmdb    

#compose启动
docker-compose up -d            

#查看日志是否有错误
tailf /var/log/supervisor/cmdb.log  
```

- 问题2：我不想改表结构怎么办？  

> 如果你是新部署的用户/没数据的用户，你完全可以给这个库/表删除了执行初始化操作  

```
docker exec -ti cmdb_codo_cmdb_1 /usr/local/bin/python3 /var/www/codo-cmdb/db_sync.py

#最后同样，如上，更新最新代码即可
```