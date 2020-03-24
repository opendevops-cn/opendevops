### SOAR部署文档
> opendevops平台所用插件SOAR部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。


**简介**

>SOAR(SQL Optimizer And Rewriter)是一个对SQL进行优化和改写的自动化工具。 由小米人工智能与云平台的数据库团队开发与维护。SOAR 主要由语法解析器、集成环境、优化建议、重写逻辑、工具集五大模块组成，相比业内其他优秀产品有自己的优势。

**功能特点**

- 跨平台支持（支持Linux, Mac环境，Windows环境理论上也支持，不过未全面测试）
- 支持基于启发式算法的语句优化
- 支持复杂查询的多列索引优化（UPDATE, INSERT, DELETE, SELECT）
- 支持EXPLAIN信息丰富解读
- 支持SQL指纹、压缩和美化
- 支持同一张表多条ALTER请求合并
- 支持自定义规则的SQL改写


**下载二进制安装包**
```
wget https://github.com/XiaoMi/soar/releases/download/0.9.0/soar.linux-amd64 -O soar
chmod a+x soar
cp soar /usr/bin/
```

**安装验证**

回到soar的下载目录执行
```
echo 'select * from film' | ./soar
```
**回显如下**
```
# Query: 687D590364E29465

★ ★ ★ ☆ ☆ 75分

``sql

SELECT  
  * 
FROM  
  film
``

##  最外层SELECT未指定WHERE条件

* **Item:**  CLA.001

* **Severity:**  L4

* **Content:**  SELECT语句没有WHERE子句，可能检查比预期更多的行(全表扫描)。对于SELECT COUNT(\*)类型的请求如果不要求精度，建议使用SHOW TABLE STATUS或EXPLAIN替代。

##  不建议使用SELECT * 类型查询

* **Item:**  COL.001

* **Severity:**  L1

* **Content:**  当表结构变更时，使用\*通配符选择所有列将导致查询的含义和行为会发生更改，可能导致查询返回更多的数据。

```