---
title: Vuepress环境搭建和部署
date: 2020-02-27 09:53:53
categories:
  - 前端
tags:
  - Vuepress
---

# Vuepress 环境搭建

Vuepress官网：https://vuepress.vuejs.org/
推荐一个不错的技术笔记：https://zhousiwei.gitee.io/ibooks/

## 懒人方法：

* 从github官网下载Vuepress: https://github.com/vuejs/vuepress
下载完成后，在目录：packages-> docs，其中docs就是Vuepress文档网站源码

* 运行
将docs文件夹copy到自己的工作目录
cd docs
npm install
npm run dev
本地打开项目：http://localhost:8080

## 一般方法：

参考官网：https://www.vuepress.cn/guide/getting-started.html

## 一些问题解决方法

### 如何修改Vuepress运行的ip和端口

在config.js中配置：
host
类型: string
默认值: '0.0.0.0'
指定用于 dev server 的主机名。

port
类型: number
默认值: 8080
指定 dev server 的端口

### .md文件中显示图片的方法

* 一般情况下：

```
![doc目录](/doc.png)
```
* config.js中设置了base的情况下：

如果你的网站会被部署到一个非根路径，你将需要在 .vuepress/config.js 中设置 base，举例来说，如果你打算将你的网站部署到 https://foo.github.io/bar/，那么 base 的值就应该被设置为 "/bar/" (应当总是以斜杠开始，并以斜杠结束)。

有了基础路径（Base URL），如果你希望引用一张放在 .vuepress/public 中的图片，你需要使用这样路径：/bar/image.png，然而，一旦某一天你决定去修改 base，这样的路径引用将会显得异常脆弱。为了解决这个问题，VuePress 提供了内置的一个 helper $withBase（它被注入到了 Vue 的原型上），可以帮助你生成正确的路径。

```
<img :src="$withBase('/doc.png')" alt="doc目录">
```

### Markdown中的自定义容器

输入：

```
::: tip
这是一个提示
:::

::: warning
这是一个警告
:::

::: danger
这是一个危险警告
:::

::: details
这是一个详情块，在 IE / Edge 中不生效
:::
```

输出：
<img src="/blog/images/output.jpg" alt="output">

# Vuepress 部署
文档放置在项目的 docs 目录中；
使用的是默认的构建输出位置；
VuePress 以本地依赖的形式被安装到你的项目中，并且配置了如下的 npm scripts:
``` javascript
{
  "scripts": {
    "docs:build": "vuepress build docs"
  }
}
```

* 部署到github page下

  * 在 docs/.vuepress/config.js 中设置正确的 base
  如果你打算发布到 https://<USERNAME>.github.io/，则可以省略这一步，因为 base 默认即是 "/"。
  如果你打算发布到 https://<USERNAME>.github.io/<REPO>/（也就是说你的仓库在 https://github.com/<USERNAME>/<REPO>），则将 base 设置为 "/<REPO>/"。

  * 在你的项目中，创建一个如下的 deploy.sh 文件（请自行判断去掉高亮行的注释）:
  
  ```
      #!/usr/bin/env sh

      # 确保脚本抛出遇到的错误
      set -e

      # 生成静态文件
      npm run docs:build

      # 进入生成的文件夹
      cd docs/.vuepress/dist

      # 如果是发布到自定义域名
      # echo 'www.example.com' > CNAME

      git init
      git add -A
      git commit -m 'deploy'

      # 如果发布到 https://<USERNAME>.github.io
      # git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

      # 如果发布到 https://<USERNAME>.github.io/<REPO>
      # git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages

      cd -
  ```

  你可以在你的持续集成的设置中，设置在每次 push 代码时自动运行上述脚本

* 部署到tomcat下

直接将生成的dist文件夹下的类容copy到tomcat下例如/vuepressDemo文件夹下，同理也需要在打包之前将base改为vuepressDemo，这样部署之后才能正常访问
