# 如何更新

> 主要介绍下前后端都是如何进行版本更新的
>
## 更新镜像

```sh
# 进入部署目录，例如：
cd  ./codo-deploy-docs/docker-deploy
docker-compose  -f docker-compose-app.yaml pull
```

### 重新生成token

```sh
TOKEN=$(docker exec codo_mg python3 manage.py token_init | tr -d '\n' | tr -d '\r')
sed -i "s/^CODO_AUTH_KEY\s*=.*/CODO_AUTH_KEY=\"$TOKEN\"/" .env

sed -i.bak "s/^CODO_AUTH_KEY=.*/CODO_AUTH_KEY=\"$TOKEN\"/" .env # 如果是mac
```

## 重新加载镜像

```sh
docker compose -f docker-compose-app.yaml up -d
```

## 数据库表结构变更

- 假如后端修改了表结构我怎么更新呢？

> 如果后端修改了表结构，我们的更新文档都会说明哪些需要`ALTER TABLE`,比如CMDB资产配置新增了华为云的支持，

- 问题1：我不想重新初始化，里面有数据，想直接改表结构  

```mysql  

#进到你的数据库，每个模块都是对应一个版本库的

ALTER TABLE `asset_configs` ADD `project_id` VARCHAR(120) NOT NULL ;
ALTER TABLE `asset_configs` ADD `huawei_cloud` VARCHAR(120) NOT NULL ;
ALTER TABLE `asset_configs` ADD `huawei_instance_id` VARCHAR(120) NOT NULL ;  

```

- 问题2：我不想改表结构怎么办？  

> 如果你是新部署的用户/没数据的用户，你完全可以给这个库/表删除了执行初始化操作  

```
docker exec -ti cmdb_codo_cmdb_1 /usr/local/bin/python3 /var/www/codo-cmdb/db_sync.py

#最后同样，如上，更新最新代码即可
```