---
title: Docker 的安装
categories: 工具
comments: true
tags:
  - Linux
  - Docker
abbrlink: 61830
date: 2018-01-05 22:32:58
---

Docker 是一个非常有趣的项目，可以减轻环境配置和部署的步骤。也可以十分方便的搭建起机器学习的环境。下面记录了 Linux 平台安装 Docker ，以及免 sudo 运行 Docker 命令。

<!--more-->

## 安装 Docker

已经有现成的脚本可以很方便的在不同的 Linux 版本上安装 Docker 。

```shell
sudo wget -qO- https://get.docker.com/ | sh
```

## 免 sudo 权限运行

### 添加到用户组

```shell
sudo usermod -aG docker ${USER}
```

### shell 环境生效

```shell
su - ${USER}
```

### 验证添加成功

```shell
id -nG
# output: ouyangsong sudo docker
```

## 安装 Docker-compose

可以使用 Pip 安装。

```shell
sudo pip install docker-compose
```