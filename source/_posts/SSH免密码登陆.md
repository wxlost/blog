---
title: SSH免密码登陆
categories: 笔记
comments: true
tags: Linux
abbrlink: 48748
date: 2017-08-08 00:40:43
---


平时需要管理多台 Linux 机器，所以免密码登陆 SSH 可以减少很多输密码的时间。SSH 免密码登陆只需要让两台机器添加信任关系即可，本地的话还可以给不同的远程主机设置登陆别名。

<!--more-->


## 生成密钥对

```shell
ssh-keygen
```

如果不需要设置密码的话，一路回车确认即可。

## 上传公钥

公钥意思就是公开的密钥，发布到任何地方都没有问题。需要将本地机器的公钥添加到远程机器的信任机器中。

```shell
ssh-copy-id -p 22 ouyangsong@example.com
```

## 配置别名

如果不想每次都输入用户名和远程机器的 IP 的话，可以自定义每台机器的别名。

```shell
# ~/.ssh/config
Host example
HostName example.com
User ouyangsong
Port 22
IdentityFile ~/.ssh/id_rsa.pub
IdentitiesOnly yes
```

## 失败原因

如果按照上述设置还没有成功的话，首先查看详细登陆信息。

```shell
ssh -v ouyangsong@example.com
```

如果还没有找到问题的话，可以查看一下几个方面。

- 远程机器的用户的主目录必须是**700**。
- 远程机器的 .ssh 目录权限是**700**。
- 远程机器的 .ssh/authorized_keys 的文件权限是 **644** 或者**600**。