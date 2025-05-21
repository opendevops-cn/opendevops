# codo k8s 部署

## 一键安装CODO
```shell
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

## 使用
```shell
kubectl -n codo-test port-forward services/codo-biz-frontend 8888:80
```

## 进入控制台
- 账号: admin
- 密码: 1qazXSW@

