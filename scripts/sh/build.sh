#!/bin/bash

#导入模块
source ./scripts/sh/useEnvInfo.sh;
source ./scripts/sh/useDocker.sh;
source ./scripts/sh/useNode.sh;

build_script(){
  useEnvInfo;
  node_get_package_name;
  node_get_package_version;
  node_version;
  node_npm_version;
  node_pnpm;
  node_pnpm_version;
  node_pnpm_intall;
  docker_version;
  # 需要用的变量
  DOCKER_IMAGE_NAME="${PJ_NAME}:${PJ_VERSION}"
  DOCKER_FILE_PATH="./Dockerfile"
  DOCKER_CONTEXT="."
  DOCKER_PUSH_PATH="${DOCKER_IMAGE_URL}/${DOCKER_IMAGE_URL_NAME}/${DOCKER_IMAGE_NAME}"
  # 登录镜像仓库
  docker_login ${DOCKER_LOGIN_USERNAME} ${DOCKER_LOGIN_PASSWORD} ${DOCKER_IMAGE_URL};
    # 打包镜像
  docker_build ${DOCKER_IMAGE_NAME} ${DOCKER_FILE_PATH} ${DOCKER_CONTEXT}
  # 查看镜像信息
  docker images
  # 标记镜像
  docker_tag ${DOCKER_IMAGE_NAME} ${DOCKER_PUSH_PATH}
  # 推送镜像
  docker_push ${DOCKER_PUSH_PATH}
  # 登出镜像仓库
  docker_logout;
};

build_script;
