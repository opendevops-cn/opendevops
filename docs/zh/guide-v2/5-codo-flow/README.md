# 手把手教你玩转 一站式运维平台(CODO) - 5.使用flow编排自动化工作流

## 工作台

工作台主要用于操作流程订单

![image-20250727144732978](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727144732978.png)

## 任务中心

任务中心主要用于快速发起任务

### 常用流程

#### 流程列表

可以多选常用流程组, 在右边触发任务

![image-20250727145157748](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145157748.png)

#### 流程编辑

点击 `编辑标签` 编辑常用流程

![image-20250727145326859](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145326859.png)

![image-20250727145305048](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145305048.png)

### 脚本执行

用于快速下发物理机作业任务到 agent

![image-20250727145438329](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145438329.png)

### 文件分发

用于快速下发文件分发任务, 将一个机器上的文件分发到各个机器上(需要 安装 codo-agent)

![image-20250727145457431](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145457431.png)



### 无服务执行

用于快速下发云原生任务到 k8s 集群中执行

![image-20250802182254037](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250802182254037.png)

## 流程设计

用于配置 标准化工作流(SOP) , 进行日常作业.

![image-20250727145651197](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145651197.png)

## 脚本管理

用于配置 物理机作业 的脚本. 用于 快速执行 或者 流程引用

![image-20250727145851560](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727145851560.png)



## 接口管理

用于配置 自动化接口请求, 可以被流程引用来执行

![image-20250727150102323](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727150102323.png)

## 凭证管理

凭证是一种特殊的常量, 配置之后会端到端的加密传输到 agent 最终以环境变量的形式暴露给脚本任务

![image-20250727150203339](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727150203339.png)



## 构建机组管理

主要用于 CI 场景, 给一组构建机编组, CI 时会派发任务到其中一台

![image-20250727150508929](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727150508929.png)

## 无服务声明

新一代的 serverless 脚本任务, 整体任务运行在容器上, 可以脱离虚拟机, 只需要 k8s 的算力资源即可运行

![image-20250727150640593](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727150640593.png)

## 数据字典

用于固化业务流程的数据枚举, 以及用户可见性(数据权限)

![image-20250727150757721](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727150757721.png)



## 节点管理

主要用于管理 codo-agent , 以及 agent 扩展

### 节点列表(定时同步)

agent 基础信息展示, 可以在这里给 agent 升级 & 安装插件.

![image-20250727151132061](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727151132061.png)

### 组网列表

agent 和 server 之间开辟的一条 专属信道可以 跨网络、跨区域 运输任意 TCP 流量到对端

![image-20250727151317766](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727151317766.png)

### 业务映射

将云原生agent与业务绑定, 从而实现 业务的 serverless 任务可以派发到对应的集群执行

![image-20250727151440148](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727151440148.png)



### 实时节点(实时连接信息)

agent 实时的连接信息表

![image-20250727151556695](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727151556695.png)
