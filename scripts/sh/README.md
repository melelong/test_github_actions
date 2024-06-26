# 使用文档

### 1、各环境对应的分支配置

项目根目录下 `.circleci` 的 `config.yml`

### 2、circleci 访问用户

```shell
# 在部署服务器上新建
# SSH用此用户登录
# 新建用户
sudo useradd circleci
# 添加密码
sudo passwd circleci
# 添加权限(其他权限可后续按需加，这里只举docker例子)
sudo usermod -aG docker circleci
# 重启docker
sudo systemctl restart docker
# 切换用户测试
su - circleci
# 查看docker版本
docker -v
```

### 3、依赖环境变量

```shell

# 至少填一种环境（必填）
# 生产环境
# PRO_DOCKER_LOGIN_USERNAME 生产环境docker镜像仓库用户名
# PRO_DOCKER_LOGIN_PASSWORD 生产环境docker镜像仓库密码
# PRO_DOCKER_IMAGE_URL  生产环境docker镜像仓库地址
# PRO_DOCKER_IMAGE_URL_NAME 生产环境docker镜像仓库命名空间
# PRO_SSH_USER  生产环境ssh用户名
# PRO_SSH_PW  生产环境ssh用户密码（默认要填，KEY模式下不需要填）
# PRO_SSH_HOST  生产环境ssh主机
# 测试环境
# TEST_DOCKER_LOGIN_USERNAME  测试环境docker镜像仓库用户名
# TEST_DOCKER_LOGIN_PASSWORD  测试环境docker镜像仓库密码
# TEST_DOCKER_IMAGE_URL 测试环境docker镜像仓库地址
# TEST_DOCKER_IMAGE_URL_NAME 测试环境docker镜像仓库命名空间
# TEST_SSH_USER 测试环境ssh用户名
# TEST_SSH_PW  测试环境ssh用户密码（默认要填，KEY模式下不需要填）
# TEST_SSH_HOST 测试环境ssh主机
# 开发环境
# DEV_DOCKER_LOGIN_USERNAME 开发环境docker镜像仓库用户名
# DEV_DOCKER_LOGIN_PASSWORD 开发环境docker镜像仓库密码
# DEV_DOCKER_IMAGE_URL  开发环境docker镜像仓库地址
# DEV_DOCKER_IMAGE_URL_NAME 开发环境docker镜像仓库命名空间
# DEV_SSH_USER  开发环境ssh用户名
# DEV_SSH_PW  开发环境ssh用户密码（默认要填，KEY模式下不需要填）
# DEV_SSH_HOST  开发环境ssh主机

# CIRCLECI_FINGERPRINTS  circleci私钥指纹（KEY模式下要填，默认不需要填）

# 选填
# SSH_MODE SSH连接模式（默认是PW,即账号密码登录；另一种是KEY,即通过密钥登录）
```

### 4、SSH 后对远程服务器的操作

项目根目录下 `scripts/sh`目录下的`SSH_shell.sh`、`deploy.sh` 和 `useSSH.sh`

> `SSH_shell.sh`文件可以使用`useSSH.sh`中`SSH_inject`注入的变量和模块函数

### 5、关于`KEY` 模式

阅读https://circleci.com/docs/deploy-over-ssh/ & https://circleci.com/docs/add-ssh-key/

> PS：关于后续功能扩展，可以基于`use`开头为模块文件命名，其他命名文件为运行脚本进行扩展
