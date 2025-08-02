# 手把手教你玩转 一站式运维平台(CODO) - 3.2 配置角色权限

## 权限流

![output](https://raw.githubusercontent.com/Ccheers/pic/main/img/output.png)

## 配置基础角色(权限包)

### 进入权限配置菜单

![image-20250727143432258](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727143432258.png)

### 配置对应的菜单+接口权限

![image-20250727143517152](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727143517152.png)

![image-20250727143526215](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727143526215.png)



## 配置通用角色(业务角色)

### 切换通用角色页

![image-20250727143924943](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727143924943.png)

### 关联用户和权限包

![image-20250727143826880](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727143826880.png)

## [可选] 点击刷新缓存

将权限信息立刻刷入ETCD中, 这一步有异步任务定时同步, 所以可选

![image-20250727144004623](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250727144004623.png)