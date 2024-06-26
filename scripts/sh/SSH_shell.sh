#!/bin/bash

# 可以使用./scripts/sh/useDocker.sh中SSH_inject注入代码模块和变量

# SSH后远程的操作
docker_version;
docker_login ${DOCKER_LOGIN_USERNAME} ${DOCKER_LOGIN_PASSWORD} ${DOCKER_IMAGE_URL};

docker_logout;
