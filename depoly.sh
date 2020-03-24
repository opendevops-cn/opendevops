#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

#创建.nojekyll 防止Github Pages build错误
touch .nojekyll

git init
echo "docs.opendevops.cn" > CNAME
git add -A
git commit -m 'deploy'

git push -f "https://github.com/opendevops-cn/opendevops-cn.github.io.git" master

cd -
