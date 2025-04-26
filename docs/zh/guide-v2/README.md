## codo V2 使用指南

## 目录

- [codo V2 使用指南](#codo-v2-使用指南)
    - [系统架构](./1-architectures/README.md) @cc
    - [安装说明](./2-install/README.md) @cc
      - [docker安装说明](./2-install/docker.md)
      - [k8s安装说明](./2-install/k8s.md)
    - [admin - 管理用户权限](./3-admin/README.md) @klein
      - [使用admin配置权限](./3-admin/role-auth.md)
    - [CMDB - 管理数据资源](./4-cmdb/README.md) @dongdong
      - [使用CMDB管理云上数据资产](./4-cmdb/cloud-asset.md)
      - [使用CMDB管理业务树](./4-cmdb/biz-tree.md) 
    - [flow - 编排自动化工作流](./5-codo-flow/README.md) @cc @klein
      - [安装 codo-agent](./5-codo-flow/codo-agent.md) @cc
      - [配置自动化工作流](./5-codo-flow/flow.md) @cc
      - [配置codo动态表单](./5-codo-flow/form.md) @cc
      - [配置codo流程自动触发](./5-codo-flow/trigger.md) @cc
      - [案例 - 使用 codo-flow 实现 golang 应用自动化部署](./5-codo-flow/example-golang.md) @cc
      - [案例 - 使用 codo-flow 执行 云原生无状态任务](./5-codo-flow/example-cntask.md) @cc
      - [案例 - 使用 codo-flow + cmdb 实现 跨地区应用部署](./5-codo-flow/example-distribute-deploy.md) @klein
    - [配置中心 - 管理配置](./6-config-center/README.md) @dongdong
    - [通知中心 - 完成高效率告警](./7-notice/README.md) @cc
      - [案例 - 使用配置中心 完成用户操作审批](./7-notice/example-audit.md)
    - [云原生管理平台 - 管理多地集群](./8-cloud-native-management/README.md) @dongdong
      - [案例 - 使用云原生管理平台 审计kubectl操作](./8-cloud-native-management/example-kubectl-audit.md)
