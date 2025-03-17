# Docker Compose部署

::: tip
完全抽象出来的本地部署方式，不理解Docker的同学可以使用本文的进行参考

部署视频参考：

视频会在业余时间持续录制，更多视频可以参考Up主空间：https://space.bilibili.com/388245257/

- [部署安装教程](https://www.bilibili.com/video/BV1BL4y1a7TU/)
- [快速了解视频](https://www.bilibili.com/video/BV1rp4y1v7fa/)
- [二次开发教程](https://www.bilibili.com/video/BV1Sy4y137md/)

:::

## 项目简介

- 本项目采用微服务架构，完成全球一站式运维体系建设。

- Demo 地址：https://demo.opendevops.cn/user/login  `用户：demo 密码：2ZbFYNv9WibWcR7GB6kcEY`

```text
codo
├── codo-admin # 管理后台
├── codo-agent-server # 底层管控
├── codo-cloud-agent-operator # 执行云原生任务
├── codo-cmdb # 数据资产、多云资源管理
├── codo-cnmp # 云原生管理平台
├── codo-flow-servers # 任务平台、作业调度执行
├── codo-monitor # 可观测平台
├── codo-notice #  通知中心
├── codo-frontend # 前端应用、流量入口(API流量 先进这里再路由到 gateway)
├── codo-gateway # API网关
└── codo-kerrigan # 配置中心

```

## 环境依赖

- 操作系统：Rocky Linux 9.1以上 x86_64
- Python版本：3.9
- Docker版本：最新稳定版本
- Docker Compose版本：最新稳定版本
- mysql: 8.0
- redis: 6.2
- rabbitmq: 3.11
- etcd: 3.5

**优化系统**

注意：

- 如果你的系统是新的，我们建议你先优化下系统，同样我们也提供了[优化系统脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts/system_init_v1.sh)
- 以下基础环境中，若你的系统中已经存在可跳过，直接配置，建议使用我们推荐的版本

## 快速部署
- 开发环境使用docker-compose方式, 完成管理后台、网关服务、前端项目、任务平台、配置中心、Agent-server的部署.
- 部署时先部署中间件, 中间件正常运行后部署应用.
- 安装 Docker 和 Docker-compose
  
> Docker安装命令参考 **[Rocky Linux 9 操作系统]**

```shell
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
  ```

> docker-compose安装命令参考 **[Rocky Linux 9 操作系统]**

```shell
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

---

**克隆仓库**

```shell
mkdir -p /opt/codo/ && cd /opt/codo/
git clone https://github.com/opendevops-cn/codo-deploy-docs.git
cd codo-deploy-docs/docker-deploy
```

- 配置文件修改【可选】[.env](https://github.com/opendevops-cn/codo-deploy-docs/blob/main/docker-deploy/.env) <span style="color: red;">
  中已经配置项目中所需的账密信息，不修该则使用默认配置</span>
- 数据库初始化【可选】：[db_init.sql](https://github.com/opendevops-cn/codo-deploy-docs/blob/main/docker-deploy/db_init.sql) <span style="color: red;"> 在 Docker 部署 MySQL 时默认导入。

--- 

- 部署中间件 如需依赖已有中间件则需要修改[.env](.env)配置

```shell
sh ./deploy_middleware.sh
```

--- 

- 启动服务并初始化

```shell
sh ./init_app.sh
```

- 管理后台创建超级用户

> 默认的admin 密码为 1qazXSW@

```shell
docker exec -it codo_mg python3 manage.py createsuperuser
```
