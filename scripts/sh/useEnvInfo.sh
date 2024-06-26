#!/bin/bash

DOCKER_LOGIN_USERNAME="";
DOCKER_LOGIN_PASSWORD="";
DOCKER_IMAGE_URL="";
DOCKER_IMAGE_URL_NAME="";
SSH_USER="";
SSH_PW="";
SSH_HOST="";
SSH_FINGERPRINTS="";
DEFAULT_SSH_MODE="";

init_env_var(){
  check_config_var
  set_mode_var
  set_build_var
  check_build_var
  set_deploy_var
  check_deploy_var
  echo_all_var
};

set_mode_var(){
  if [ -z "${SSH_MODE+set}" ]; then
    DEFAULT_SSH_MODE="PW"
  else
    DEFAULT_SSH_MODE=${SSH_MODE}
  fi
  echo "SSH模式为 ${DEFAULT_SSH_MODE}"
};

check_config_var(){
  echo "正在检测配置文件变量..."
  if [ -z "${ENV_NAME+set}" ]; then
    echo "error: 配置文件变量 ENV_NAME 未配置" >&2
    exit 1
  else
    echo "配置文件变量检测通过"
  fi
};

check_build_var() {
  echo "正在检测 ${ENV_NAME} 环境打包阶段配置..."
  if [ "${DOCKER_LOGIN_USERNAME}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 DOCKER_LOGIN_USERNAME 未配置" >&2
    exit 1
  elif [ "${DOCKER_LOGIN_PASSWORD}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 DOCKER_LOGIN_PASSWORD 未配置" >&2
    exit 1
  elif [ "${DOCKER_IMAGE_URL}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 DOCKER_IMAGE_URL 未配置" >&2
    exit 1
  elif [ "${DOCKER_IMAGE_URL_NAME}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 DOCKER_IMAGE_URL_NAME 未配置" >&2
    exit 1
  else
    echo "${ENV_NAME} 环境打包阶段配置检测通过"
  fi
};

set_build_var(){
  if [ "${ENV_NAME}" == "pro" ]; then
    DOCKER_LOGIN_USERNAME=${PRO_DOCKER_LOGIN_USERNAME}
    DOCKER_LOGIN_PASSWORD=${PRO_DOCKER_LOGIN_PASSWORD}
    DOCKER_IMAGE_URL=${PRO_DOCKER_IMAGE_URL}
    DOCKER_IMAGE_URL_NAME=${PRO_DOCKER_IMAGE_URL_NAME}
  elif [ "${ENV_NAME}" == "test" ]; then
    DOCKER_LOGIN_USERNAME=${TEST_DOCKER_LOGIN_USERNAME}
    DOCKER_LOGIN_PASSWORD=${TEST_DOCKER_LOGIN_PASSWORD}
    DOCKER_IMAGE_URL=${TEST_DOCKER_IMAGE_URL}
    DOCKER_IMAGE_URL_NAME=${TEST_DOCKER_IMAGE_URL_NAME}
  elif [ "${ENV_NAME}" == "dev" ]; then
    DOCKER_LOGIN_USERNAME=${DEV_DOCKER_LOGIN_USERNAME}
    DOCKER_LOGIN_PASSWORD=${DEV_DOCKER_LOGIN_PASSWORD}
    DOCKER_IMAGE_URL=${DEV_DOCKER_IMAGE_URL}
    DOCKER_IMAGE_URL_NAME=${DEV_DOCKER_IMAGE_URL_NAME}
  else
    echo "error: 配置文件变量 ENV_NAME 未配置" >&2
    exit 1
  fi
};

check_deploy_var() {
  echo "正在检测 ${ENV_NAME} 环境部署阶段配置..."
  if [ "${SSH_USER}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 SSH_USER 未配置" >&2
    exit 1
  elif [ "${SSH_HOST}" == "" ]; then
    echo "error: ${ENV_NAME} 环境变量 SSH_HOST 未配置" >&2
    exit 1
  elif [ "${SSH_FINGERPRINTS}" == "" ] && [ "${DEFAULT_SSH_MODE}" == "KEY" ]; then
    echo_private_key
    echo "error: 环境变量 CIRCLECI_FINGERPRINTS 未配置" >&2
    exit 1
  elif [ "${SSH_PW}" == "" ] && [ "${DEFAULT_SSH_MODE}" == "PW" ]; then
    echo "error: ${ENV_NAME}环境变量 SSH_PW 未配置" >&2
    exit 1
  else
    echo "${ENV_NAME} 环境部署阶段配置检测通过"
  fi
};


set_deploy_var(){
  SSH_FINGERPRINTS=${CIRCLECI_FINGERPRINTS}
  if [ "${ENV_NAME}" == "pro" ]; then
    if [ "${DEFAULT_SSH_MODE}" == "PW" ]; then
      SSH_PW=${PRO_SSH_PW}
    fi
    SSH_USER=${PRO_SSH_USER}
    SSH_HOST=${PRO_SSH_HOST}
  elif ["${ENV_NAME}" == "test" ]; then
    if [ "${DEFAULT_SSH_MODE}" == "PW" ]; then
      SSH_PW=${TEST_SSH_PW}
    fi
    SSH_USER=${TEST_SSH_USER}
    SSH_HOST=${TEST_SSH_HOST}
  elif [ "${ENV_NAME}" == "dev" ]; then
    if [ "${DEFAULT_SSH_MODE}" == "PW" ]; then
      SSH_PW=${DEV_SSH_PW}
    fi
    SSH_USER=${DEV_SSH_USER}
    SSH_HOST=${DEV_SSH_HOST}
  else
    echo "error: 配置文件变量 ENV_NAME 未配置" >&2
    exit 1
  fi
};

echo_all_var(){
  echo "DOCKER_LOGIN_USERNAME: ${DOCKER_LOGIN_USERNAME}"
  echo "DOCKER_LOGIN_PASSWORD: ${DOCKER_LOGIN_PASSWORD}"
  echo "DOCKER_IMAGE_URL: ${DOCKER_IMAGE_URL}"
  echo "DOCKER_IMAGE_URL_NAME: ${DOCKER_IMAGE_URL_NAME}"
  echo "SSH_USER: ${SSH_USER}"
  echo "SSH_PW: ${SSH_PW}"
  echo "SSH_HOST: ${SSH_HOST}"
  echo "SSH_FINGERPRINTS: ${SSH_FINGERPRINTS}"
  echo "DEFAULT_SSH_MODE: ${DEFAULT_SSH_MODE}"
};

echo_env(){
  echo "${ENV_NAME} 环境"
};

echo_public_key(){
  echo_line
  echo " 'KEY' 模式中第一次使用请复制 'circleci公钥' 到ssh远程主机的 '~/.ssh/authorized_keys' 中"
  echo "手动登录ssh远程主机"
  echo "命令: vim ~/.ssh/authorized_keys"
  cat ~/.ssh/id_rsa.pub
  echo "'i' 编辑，'ESC' 退出编辑，输入 ':wq' 退出保存即可"
  echo "后续添加其他的ssh远程主机，重复此步骤即可"
  echo_line
};

echo_private_key(){
  echo_line
  echo "请复制 'circleci私钥'"
  cat ~/.ssh/id_rsa
  echo "到circleci项目的 'Project Settings' > 'SSH Keys' > 'Additional SSH Keys' > 'Add SSH Key'"
  echo "获取 'Fingerprint' 后，设置环境变量 CIRCLECI_FINGERPRINTS "
  echo "PS:(https://circleci.com/docs/deploy-over-ssh/ & https://circleci.com/docs/add-ssh-key/)"
  echo_line
};

echo_line(){
  echo "****************************************"
};

useEnvInfo(){
  echo_env
  init_env_var
};

export -f init_env_var
export -f echo_public_key
export -f echo_line
export -f useEnvInfo
