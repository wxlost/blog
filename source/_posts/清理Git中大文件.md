---
title: 清理 Git 中大文件
categories: 笔记
comments: true
mathjax: false
tags:
  - Git
  - Git-LFS
abbrlink: 60716
date: 2018-03-19 08:50:44
---

博客中的图片和视频等二进制文件都是放到 Git 仓库中，导致仓库越来越大。Git Large File Storage (LFS) 是专门用来存储体积大的二进制文件，于是我将所有图片和视频都放到 Git-LFS 中，这个时候仓库中只有存储图片和视频等二进制文件在 Git-LFS 服务器中的地址即可。

<!--more-->

## 清理历史

在清理历史之前，一定要备份好你的图片或者视频等二进制文件，这是血淋淋的教训。当时我只能在 `public` 文件夹中一个一个找出来，其他地方都被删除了。

```git
# 查看空间使用
git count-objects -v
# 查看前 5 大的文件
git verify-pack -v .git/objects/pack/pack-*.idx | sort -k 3 -g | tail -5
# 找出对应的文件名
git rev-list --objects --all | grep 8f10eff9
# 删除图片
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch source/_posts/*/*.jpg' --prune-empty --tag-name-filter cat -- --all
# 回收空间
rm -rf .git/refs/original/ 
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
# 强制推送到远端
git push origin --force --all
```

## 使用 Git-LFS

```git
# 安装 git-lfs
brew install git-lfs
# 关联相关仓库
git lfs track "source/_posts/*/*.jpg"
# 上传 git-lfs 文件
git add source/_posts/
git commit -m"add git lfs"
git push origin master
```

关于确认是否用上了 Git-LFS ，可以使用下面的方法来确认。

```git
git lfs ls-files
```

或者在 `push` 的时候，会显示 `Uploading LFS objects` 。

至此，在仓库中二进制文件都变成了一些远程地址了，极大地减小了仓库的大小。

```
version https://git-lfs.github.com/spec/v1
oid sha256:583236d0803441010279375b8f5da4812ae82aa96e0ba2d5b6d67f1162f670eb
size 87859
```

## 参考文件

- [Configuring Git Large File Storage](https://help.github.com/articles/configuring-git-large-file-storage/)
- [Removing sensitive data from a repository](https://help.github.com/articles/removing-sensitive-data-from-a-repository/)
