---
title: SSH 使用小技巧
categories: 工具
comments: true
mathjax: false
tags:
  - SSH
  - 端口转发
abbrlink: 63538
date: 2018-02-06 10:27:09
---

SSH 的端口转发功能可以加密 Client 和 Server之间的通讯数据，还可以突破防火墙的限制。北邮的电脑上网，ipv4 地址是每次连接网关时动态分配，ipv6 地址是不会变的。可以利用端口转发来连接实验室机器，无视它的 ip 每次都变化。

<!--more-->


## 基本参数含义

| 参数 | 功能         |
|------|--------------|
| -C   | 压缩数据传输 |
| -f   | 后台运行     |
| -N   | 不执行shell  |
| -L   | 本地端口转发 |
| -R   | 远程端口转发 |
| -D   | 动态端口转发 |

## 远程端口转发

远程端口可以把本地的端口转发到远程机器上，实现反向端口转发

### 登陆端口转发

我们面对的是这样的场景：实验室有一台机器，然后希望可以通过 SSH 连接上去跑机器学习实验，但是由于学校网络问题，实验室的机器的 ip 经常发生改变，而且因为该机器没有公网 ip ，所以只能校园网内通过局域网 ip 连接。    

解决这个问题，我们首先需要一台公网机器，比如腾讯云或者阿里云，要求它有一个公网 ip ，然后实验室机器和客户端机器都可以连接到公网机器。下面为了便于表述，我将实验室的机器称为 lab，公网机器称为 jump，连接的客户端为 client 。为了实验室机器能够开机就能连接公网机器，可以参考 [命令行登陆校园网](/posts/43250/) 来自动登陆网关。我们在 lab 机器上有一个用户为 ouyangsong，在 jump 机器上有个用户为 jumpuser 。

![](remote-port-forwarding.svg "远程端口转发示意图")

为了方便后续的登陆，首先需要建立 ouyangsong 到 jumpuser 的免密码登陆，也就是说 lab 机器可以不需要密码就可以登陆到 jump 机器。具体可以参考 [SSH 免密码登陆](/posts/48748/) 。

```shell
lab$ ssh -R 10022:localhost:22 jumpuser@jump
```

R 参数接受三个值，分别是“远程主机端口:目标主机:目标主机端口” 。这条命令的意思就是，让 jump 机器监听它的 10022 端口，然后所有数据经过 lab 转发到 lab 的 22 端口。这时候我们可以在 jump 机器上通过 `ss -ant` 命令看到它已经监听本地（指 jump 机器本地）的 10022 端口。

```shell
jump$ ssh ouyangsong@lab -p10022
lab$
```

这样的话首先登陆到 jump 机器，然后输入 ouyangsong 在 lab 机器上的密码就可以登陆到 lab 机器。但是这样还是略显麻烦，可以把 jump 机器的 ssh 端口开放在 `0.0.0.0` 而不是默认的 `127.0.0.1` 就可以直接在 client 端登陆到 lab 机器。修改 `/etc/ssh/sshd_config` 文件，添加 `GatewayPorts yes` 。然后重启 sshd 服务，`sudo reload ssh`。这时候还需要把远程端口转发命令做点小修改。

```shell
lab$ ssh -R 0.0.0.0:10022:localhost:22 jumpuser@jump
```

经过上面的修改我们可以在 client 上执行如下命令就可以登陆 lab 机器了，成功突破了校园网的限制。注意用户名为 lab 上的用户名，jump 机器不存在 ouyangsong 用户。

```shell
client$ ssh ouyangsong@jump -p10022
```

但是还有点小问题就是如果网络不稳定，那么 ssh 服务就会断了，这时候我们需要重新连接 ssh ，可以使用 autossh 工具。

```shell
sudo apt install autossh
# M 参数指定监视连接状态端口
autossh -M 10023 -fNR 0.0.0.0:10022:localhost:22 jumpuser@jump
```

然后添加到开机自启中，`/etc/rc.local` 最后添加下面命令：

```shell
su - ouyangsong -c 'autossh -M 10023 -fNR 0.0.0.0:10022:localhost:22 jumpuser@jump'
```

### Web 端口转发

实验室机器上跑了一个 web 服务，比如 `python -m SimpleHTTPServer`，默认我们只能在实验室机上的本地 8000 端口 （http://localhost:8000) 访问，假如我不在校园网环境并且希望访问该 web 服务。

```shell
lab$ ssh -NR 0.0.0.0:18000:localhost:8000 jumpuser@jump
```

这样的话我就可以在公网 ip 的 18000 端口访问该服务。

### 代理端口转发

假如实验室机器 lab 上有 HTTP 代理服务，运行在 1080 端口，希望 jump 机器可以使用该代理服务。

```shell
lab$ ssh -NR 11080:localhost:1080 jumpuser@jump
lab$ ssh jumpuser@jump
jump$ export ALL_PROXY=http://127.0.0.1:11080
jump$ curl ip.sb
```

## 本地端口转发

本地端口转发将远程的端口转发到本地，实现正向端口代理。刚刚我们把 lab 的 22 端口反向转发到 jump 的 10022 端口，现在再把它正向端口转发到 lab 的 20022 端口。

```shell
lab$ ssh -NL 20022:localhost:10022 jumpuser@jump
```

L 参数同样接受三个值，分别是“本地端口:目标主机:目标主机端口”，在这里本地端口是 20022，我们把 jump 机器的“本地端口” 10022 端口转发到本地端口 20022，注意这里的 localhost 是相对与 jump 机器来说的。

## 动态端口转发

假如我们可以通过跳板机来连接到内网机器 lab，我们希望访问网页时也经过该代理。或者另外一种情景，希望把未加密的数据经过 ssh 来进行加密连接。

```shell
client$ ssh -ND 1080 ouyangsong@jump
```

这样的话，client 机器的 1080 端口的数据，会经过跳板机然后到内网机器 lab 。然后在浏览器通过插件 [Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif?hl=en) 设置代理为 `socks5://127.0.0.1:1080`，这样就实现了自制的内网的 VPN 。