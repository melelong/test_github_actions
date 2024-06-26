#!/bin/bash

#导入模块
source ./scripts/sh/useEnvInfo.sh;
source ./scripts/sh/useSSH.sh;
source ./scripts/sh/useNode.sh;

deploy_script(){
  useEnvInfo;
  SSH_version;
  node_version;
  node_get_package_name;
  node_get_package_version;
  SSH_inject;
  SSH_login;
};

deploy_script;