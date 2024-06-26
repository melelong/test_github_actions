#!/bin/bash

# 模块文件路径必须写前面，最后./scripts/sh/SSH_shell.sh必须写后面
# 注入代码（顺序：要用到的变量，要用到的模块文件，SSH_shell文件）
# 后续按照顺序注入，PS：注入后的操作，前提登录账号要有权限
SSH_inject(){
    SSH_shell=$(
    echo "PJ_NAME=${PJ_NAME}; PJ_VERSION=${PJ_VERSION}; DOCKER_LOGIN_USERNAME=${DOCKER_LOGIN_USERNAME}; DOCKER_LOGIN_PASSWORD=${DOCKER_LOGIN_PASSWORD}; DOCKER_IMAGE_URL=${DOCKER_IMAGE_URL}; DOCKER_IMAGE_URL_NAME=${DOCKER_IMAGE_URL_NAME}; $(cat ./scripts/sh/useDocker.sh) $(cat ./scripts/sh/SSH_shell.sh)"
  )
};

# 参数顺序：SSH_USER SSH_HOST
SSH_login_use_key(){
  echo "正在登录SSH..."
  if ! ssh -t -o StrictHostKeyChecking=no "$1"@"$2" "${SSH_shell}"; then
    echo "SSH登录失败" >&2
    exit 1
  else
    echo "SSH登录成功"
  fi
};

# 参数顺序：SSH_USER SSH_PW SSH_HOST
SSH_login_use_password(){
  sudo apt-get install sshpass
  echo "正在登录SSH..."
  if ! sshpass -p $2 ssh -t -o StrictHostKeyChecking=no "$1"@"$3" "
  ${SSH_shell}"; then
    echo "SSH登录失败" >&2
    exit 1
  else
    echo "SSH登录成功"
  fi
};

SSH_login(){
  if [ "${DEFAULT_SSH_MODE}" == "PW" ]; then
    SSH_login_use_password ${SSH_USER} ${SSH_PW} ${SSH_HOST}
  else
    SSH_login_use_key ${SSH_USER} ${SSH_HOST}
  fi
};

SSH_logout(){
  echo "正在登出SSH..."
  if ! ssh -o StrictHostKeyChecking=no "$1"@"$2" "exit"; then
    echo "SSH登出失败" >&2
    exit 1
  else
    echo "SSH登出成功"
  fi
};

SSH_version(){
  echo "SSH版本"
  ssh -V
};

export -f SSH_inject;
export -f SSH_login_use_key;
export -f SSH_login_use_password;
export -f SSH_login;
export -f SSH_logout;
export -f SSH_version;