# 手把手教你玩转 一站式运维平台(CODO) - 5.4 codo-flow 配置流程审批

## 通知中心配置

1. ### 配置消息模板

如何获取消息

流程系统会把所有消息回调给消息中心

```Plain
codo_callback_args 系统间回调信息，不用管
codo_flow_creator  订单发起者
title： 订单名称
codo_noticer：通知人
flow_bpm_name：当前审批节点的名称
其他变量都可以直接在通知模板中取用
```

![1280X1280](../images/1280X1280.png)

1. ### 配置通知通道

![1280X1280 (1)](../images/1280X1280_1.png)

![1280X1280 (2)](../images/1280X1280_2.png)

配置回调地址

```Plain
# 同意
https://{补上网关地址}/api/f2-acc/public/v1/flow/approval/agree/
# 拒绝
https://{补上网关地址}/api/f2-acc/public/v1/flow/approval/reject/
```

1. ### 编辑通知路由

> 固定用法 创建 flow_approval=yes   user_task=type1 的路由条件

![1280X1280 (3)](../images/1280X1280_3.png)

## 流程配置

1. ### 创建流程

![be1cbe35-168f-492b-a13b-a87b97461a19](../images/be1cbe35-168f-492b-a13b-a87b97461a19.png)

1. ### 使用用户类型的任务

![780e63a7-9178-4d69-91ec-c1a8456a57f8](../images/780e63a7-9178-4d69-91ec-c1a8456a57f8.png)

1. ### 发布流程

![d4a9ed61-635b-4c52-9533-2050a7c0e94f](../images/d4a9ed61-635b-4c52-9533-2050a7c0e94f.png)

1. ### 点击触发即可

![fd581805-df3f-4724-beec-1168e707a4ae](../images/fd581805-df3f-4724-beec-1168e707a4ae.png)

![image-20250802160044602](../images/image-20250802160044602.png)