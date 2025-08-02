# 手把手教你玩转 一站式运维平台(CODO) - 8.使用云原生管理平台管理多地集群



## 集群接入

填入kubeconfig 即可完成接入

- 需要注意服务器和 kubeconfig 的 api 地址网络联通性
- 使用最高权限的 kubeconfig 导入

![image-20250802160413954](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802160413954.png)





## 凭证导出

权限配置好之后, 可以导出访问凭证, 导出的凭证用户流量会先进入到 灵息 平台, 由 灵息 平台代理到目标集群

从而可以无感实现

- 操作审计
- 权限控制

![image-20250802174831908](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802174831908.png)



## 权限配置

### 配置角色

一般来说不需要特别配置角色, 预置的管理员以及只读足够了

![image-20250802175113260](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802175113260.png)

### 用户组授权

**用户组授权需要需要先在 [后台管理 配置好角色](../3-admin/role-auth.md)**

![image-20250802174447211](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802174447211.png)



## 操作审计

![image-20250802174743181](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802174743181.png)

