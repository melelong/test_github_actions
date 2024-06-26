node_version(){
  echo "node版本"
  sudo node -v
};

node_get_package_name(){
  PJ_NAME=$(node ./scripts/sh/getPackageName.cjs)
  echo "项目名"
  echo ${PJ_NAME}
};

node_get_package_version(){
  PJ_VERSION=$(node ./scripts/sh/getPackageVersion.cjs)
  echo "项目版本"
  echo ${PJ_VERSION}
};

node_npm_version(){
  echo "npm版本"
  sudo npm -v
};

node_npm_intall(){
  echo "正在安装依赖..."
  if sudo npm i; then
    echo "安装成功"
  else
    echo "安装失败，请检查您的网络连接" >&2
    exit 1
  fi
};

node_pnpm_version(){
  echo "pnpm版本"
  sudo pnpm -v
};

node_pnpm_intall(){
  echo "正在安装依赖..."
  if sudo pnpm i; then
    echo "安装成功"
  else
    echo "安装失败，请检查您的网络连接" >&2
    exit 1
  fi
};

node_pnpm(){
  echo "正在安装pnpm..."
  if sudo npm i -g pnpm; then
    echo "安装成功"
  else
    echo "安装失败，请检查您的网络连接" >&2
    exit 1
  fi
};

export -f node_version;
export -f node_get_package_name;
export -f node_get_package_version;
export -f node_npm_version;
export -f node_npm_intall;
export -f node_pnpm_version;
export -f node_pnpm_intall;
export -f node_pnpm;
