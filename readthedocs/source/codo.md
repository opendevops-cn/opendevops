### 项目前端

> 更新后的项目前端将不再让用户下载静态资源包，使用自动构建的方式，默认保持最新前端

```
[ ! -d /opt/codo/codo/ ] && mkdir -p /opt/codo/codo/ && cd /opt/codo/codo/
```

**一、修改域名**

下列为默认域名，如果要修改访问入口地址请修改`server_name`对应的`demo-init.opendevops.cn`，确保能DNS解析到此域名，或者自己绑定hosts来测试一下

```
cat >codo_frontend.conf <<\EOF
server {
        listen       80;
        server_name demo-init.opendevops.cn;
        access_log /var/log/nginx/codo-access.log;
        error_log  /var/log/nginx/codo-error.log;

        location / {
                    root /var/www/codo;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
        }
        location /api {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn:8888;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}
EOF

```

**创建Dockerfile**

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo

#修改nginx配置
#ADD nginx.conf /etc/nginx/nginx.conf
ADD codo_frontend.conf /etc/nginx/conf.d/codo_frontend.conf

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
EOF

```

**创建 docker-compose.yml**

```shell
cat >docker-compose.yml <<EOF
codo:
  restart: unless-stopped
  image: codo_image
  volumes:
    - /var/log/nginx/:/var/log/nginx/
    - /sys/fs/cgroup:/sys/fs/cgroup
  ports:
    - "80:80"
    - "443:443"
EOF

```

**三、编译，启动**

```shell
docker build . -t codo_image
docker-compose up -d
```


**四、测试**

```
curl  0.0.0.0:80
tailf  /var/log/nginx/codo-access.log
```
