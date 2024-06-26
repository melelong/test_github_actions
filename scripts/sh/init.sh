#!/bin/bash

#导入模块
source ./scripts/sh/useEnvInfo.sh;

init_script(){
  init_env_var;
  if [ "${DEFAULT_SSH_MODE}" == "KEY" ]; then
    echo_public_key;
  fi
};

init_script;