# 手把手教你玩转 一站式运维平台(CODO) - 3.0 使用admin管理用户权限

## 管理应用

在 CODO 中预制了自身系统的应用, 同时, 用户也可以添加自己开发的应用集成到 CODO 中来

![image-20250726173112656](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726173112656.png)

### 参数说明

- 应用编码: 作为应用的后端标识, 在权限配置中有作用
- 前端编码: 作为应用的前端标识, 在权限配置中有作用
- 名称: 应用的中文名称
- 外链: 应用的跳转链接
- 备注: 应用的解释说明

## 管理业务

业务是一种全局分类, 在 codo 的系统中起到资源隔离的作用

![image-20250726175227687](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726175227687.png)

### 参数说明

- 业务ID: 作为全局参数参与到大量的业务隔离当中
- 英文名: 业务的英文名
- 中文名: 业务的中文名

## 管理权限(接口权限)

这里权限指接口权限, 用户也可以将自己需要的鉴权的权限注册进来

![image-20250726175559276](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726175559276.png)

### 参数说明

- 应用编码: 对应上文的应用
- 权限名称: 权限的简单说明, 建议格式为 {应用}-{模块}-{权限范围}
- 请求方法: 接口的实际请求方法
- 请求路径: 请求的 URL 地址

> 建议:
>
> 权限的分类建议
>
> - GET 单独一类(只读)
> - 其他 method 一类 (管理)

## 管理菜单(前端权限)

![image-20250726180411612](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726180411612.png)

### 参数说明

- 应用编码: 对应上文的应用
- 菜单名称: 菜单的英文, 与前端路由匹配
- 备注名: 菜单的展示名称

## 管理角色

角色是权限和用户的交集表示.

![image-20250726180719570](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726180719570.png)

### 基础角色

基础角色类似权限包, 是一组一组的权限集合

![image-20250726190159372](https://raw.githubusercontent.com/Ccheers/pic/main/img/image-20250726190159372.png)

### 通用角色

用于将 基础角色(权限包) 和 用户 进行关联

![image-20250726190257479](/Users/eric/Library/Application%20Support/typora-user-images/image-20250726190257479.png)
