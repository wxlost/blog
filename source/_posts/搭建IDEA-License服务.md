---
title: 搭建 IDEA License 服务
categories: 工具
comments: true
mathjax: false
tags:
  - IDEA
  - Docker
abbrlink: 10120
date: 2018-03-08 11:16:38
---

使用 `now.sh` 提供的 `Docker` 服务来搭建 `JetBrains` 家的激活服务器。

<!--more-->

## 前言

`JetBrains` 家非常良心，学生用 [教育邮箱](https://www.jetbrains.com/zh/student/) 即可激活。创业公司可以享受 5 折 [优惠](https://www.jetbrains.com/shop/eform/startup) 。所以希望有能力的同学一定要正版支持，本文只是我用来学习 `Docker` 的实践，毕竟我有教育邮箱。同时感谢 `Lanyu` 同学的[成果](http://blog.lanyus.com/archives/174.html)。

## 部署

有服务器的同学可以部署到自己的服务器，我这里部署到 [now.sh](now.sh) 。这个平台支持静态文件、`nodejs` 和 `Docker` 服务的部署。

```docker
FROM ubuntu

LABEL maintainer="ouyangsong <songouyang@live.com>"

ADD https://github.com/songouyang/IntelliJ-IDEA-License-Server/releases/download/v1.6/IntelliJIDEALicenseServer_linux_amd64 /app/

EXPOSE 1027

RUN chmod u+x /app/IntelliJIDEALicenseServer_linux_amd64

ENTRYPOINT [ "./app/IntelliJIDEALicenseServer_linux_amd64", "-u", "ouyangsong" ]
```

## now

[注册](now.sh) 账号，安装 now 命令行。

```shell
npm install -g now
```

命令行登陆账号

```shell
now login
```

在 `Dockerfile` 所在目录进行部署。

```shell
now
```

修改别名，方便记住 URL 地址。

```
now alias intellij-idea-license-server-vivoqgthem.now.sh idea
```

保持服务一直运行。

```shell
now scale https://idea.now.sh 1
```

最终我们得到的破解服务器地址就是 `https://idea.now.sh` 。

## 激活

![activate](activate.png "激活服务器地址")

点击 `Activate` 即可激活。

![success](success.png "激活完成")

## 相关文件

上述的 `Dockerfile` 和破解程序在 [GitHub](https://github.com/songouyang/IntelliJ-IDEA-License-Server) 上。如果需要在服务器上用 `Docker` 搭建的话，可以使用该 [镜像](https://hub.docker.com/r/ouyangsong/intellij-idea-license-server/) ，使用的时候记得指定端口咯。