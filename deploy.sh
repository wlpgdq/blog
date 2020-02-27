#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# hexo清理
hexo clean

# 源文件上传github
git pull origin
git add -A
git commit -m 'update files'

git push origin master

# 打包文件使用teavis cli上传到github gh-pages分支
hexo deploy

cd -