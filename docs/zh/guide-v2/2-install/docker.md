# codo docker 部署

## 部署方式
- 开发环境使用docker-compose方式, 完成管理后台、网关服务、前端项目、任务平台、配置中心、Agent-server的部署.
- 部署时先部署中间件, 中间件正常运行后部署应用.

## 快速部署

推荐使用 root 用户进行部署

### 1. 准备 docker 环境

安装 Docker 和 Docker-compose

- Docker 安装命令参考 **[Rocky Linux 9 操作系统]**

```shell
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
```

- docker-compose 安装命令参考 **[Rocky Linux 9 操作系统]**

  ```shell
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ```

### 2. 克隆仓库

```shell
git clone https://github.com/opendevops-cn/codo-deploy-docs.git
cd ./codo-deploy-docs/docker-deploy
```

### 3. 修改配置 [可跳过]

[.env](.env)   中已经配置项目中所需的账密信息，不修改则使用默认配置

### 4. 数据库初始化 [可跳过]

[db_init.sql](db_init.sql) 在 Docker 部署 MySQL 时默认导入。

### 5. 部署中间件

如需依赖已有中间件则需要修改 [.env](.env) 配置

```shell
sh ./deploy_middleware.sh
```

### 6. 启动服务并初始化

```shell
sh ./init_app.sh
```

### 7. 管理后台创建超级用户

默认: **admin**

密码: **1qazXSW@**

```shell
docker exec -it codo_mg python3 manage.py createsuperuser
```