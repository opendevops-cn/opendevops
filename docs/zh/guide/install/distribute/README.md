# Kubenetes Helm部署

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

## 一键安装

```shell
git clone https://github.com/opendevops-cn/codo-deploy-docs.git
cd helm-deploy
bash ./quick_start/all_in_one.sh


# [optional]
# 业务参数文件
export local_biz_values_file=./data/biz.values.yaml
# 业务镜像文件
export local_biz_images_file=./data/biz.images.yaml
# 中间件参数文件
export local_mid_value_file=./data/mid.values.yaml
# 部署 cloud-agent-operator (默认不部署)
export local_deploy_crd=true
```

## 配置转发

```shell
kubectl -n codo-test port-forward services/codo-biz-frontend 8888:80
```

## 进入控制台
- 账号: admin
- 密码: 1qazXSW@