# !/usr/bin/bash

# 引入配置文件
# source config.sh

# 配置远程仓库地址
remote_repository='https://github.com/wxWidgets/wxWidgets.git'
# 配置需要检出的目录或文件，用空格分隔。注：“=”两边不能有空格
sparse_checkout_directory='samples build/msw'
# 配置检出到本地的目录
local_root='wxWidgets_samples'
# 初始化本地仓库目录
git init --initial-branch=main ${local_root}
# 切换到刚刚初始化的目录
cd ${local_root}
# 设置仓库为松散检出模式与`git config core.sparseCheckout true`同效
git sparse-checkout init
# 先设置不检出任何文件
git sparse-checkout set ""
# 设置要检出的目录和文件与`echo samples >> .git/info/sparse-checkout`同效
for item in ${sparse_checkout_directory}; do
    git sparse-checkout add ${item}
done
# 检查散检出设置
git sparse-checkout list
# 添加远程仓库地址
git remote add origin ${remote_repository}
# 检查远程仓库地址
git remote get-url --all origin
# 从远程仓库拉取我们需要的文件和目录
git pull --depth=1 origin master:main
