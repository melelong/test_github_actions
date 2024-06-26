#!/bin/bash

docker_version(){
  echo "docker版本"
  docker -v
};
# 参数顺序：DOCKER_IMAGE_NAME DOCKER_FILE_PATH DOCKER_CONTEXT
docker_build(){
  echo "正在运行打包镜像..."
  if docker build -t $1 -f $2 $3; then
    echo "打包镜像成功"
  else
    echo "打包镜像失败" >&2
    exit 1
  fi
};

# 参数顺序: DOCKER_IMAGE_NAME DOCKER_PUSH_PATH
docker_tag(){
  echo "正在标记镜像..."
  if docker tag $1 $2; then
    echo "标记镜像成功"
  else
    echo "标记镜像失败" >&2
    exit 1
  fi
};

# 参数顺序：DOCKER_PUSH_PATH
docker_push(){
  echo "正在运行推送镜像..."
  if docker push $1; then
    echo "推送镜像成功"
  else
    echo "推送镜像失败" >&2
    exit 1
  fi
};

# 参数顺序：DOCKER_LOGIN_USERNAME DOCKER_LOGIN_PASSWORD DOCKER_IMAGE_URL
docker_login(){
  if $# != 3; then
    echo "Usage:  <DOCKER_LOGIN_USERNAME> <DOCKER_LOGIN_PASSWORD> <DOCKER_IMAGE_URL>" >&2
    exit 1
  fi
  echo "正在登录docker镜像仓库..."
  if echo "$2" | docker login -u "$1" --password-stdin "$3"; then
    echo "docker镜像仓库登录成功"
  else
    echo "docker镜像仓库登录失败，请检查您的凭据和网络连接" >&2
    exit 1
  fi
};

docker_logout(){
  echo "正在登出docker镜像仓库..."
  if docker logout; then
    echo "登出成功"
  else
    echo "登出失败，请检查您的Docker环境" >&2
    exit 1
  fi
};

export -f docker_version;
export -f docker_build;
export -f docker_tag;
export -f docker_push;
export -f docker_login;
export -f docker_logout;
