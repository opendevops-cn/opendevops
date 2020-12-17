# SQLAdvisor

[[toc]]

::: tip
插件部署提供参考
:::

###  SQLAdvisor部署文档

> opendevops平台所用插件SQLAdvisor部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。


**简介**

>SQLAdvisor是一个分析SQL给出索引优化建议的工具。它基于MySQL原生态词法解析，结合分析SQL中的where条件、聚合条件、多表Join关系 给出索引优化建议。  主要功能：输出SQL索引优化建议,[更多介绍](https://github.com/Meituan-Dianping/SQLAdvisor/blob/master/doc/THEORY_PRACTICES.md)


**安装使用**

```
#编译依赖项sqlparser
git clone https://github.com/Meituan-Dianping/SQLAdvisor.git
cd SQLAdvisor
1.cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=debug -DCMAKE_INSTALL_PREFIX=/usr/local/sqlparser ./
2.make && make install

#安装SQLAdvisor源码
cd SQLAdvisor/sqladvisor/
cmake -DCMAKE_BUILD_TYPE=debug ./
make
cp sqladvisor  /usr/bin/

#使用帮助
sqladvisor  --help

#举个栗子
sqladvisor  -u root -p 123456 -P 3306 -h 10.0.0.24 -q "select permission_id from base_server_user_group_permission_relation;" -d work_permission_0 -v 1
```

> 编译完成后可删除整个sqladvisor目录，仅保留可执行文件sqladvisor。
