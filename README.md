# GeekTR Private Cloud 开发基础服务

## 简介

本项目为本人家用开发相关服务器的 Ansible 部署脚本

服务器硬件架构分为两部分，家中虚拟机
外加一台安装 ROS 的云服务器，将 22/80/443 转发到内网

## 目录结构

(ansible 相关)
- ansible.cfg
- group_vars
- hosts
- requirements.yml
- roles
- secret_vars
- ssh.cfg
- ssh_keys
- ssl_keys
- templates

(服务器 Ansible 脚本)
- main.yml
- gitlab_runner.yml

(esxi 虚拟机初始化脚本)
- init/vm

(minio 存储初始化脚本)
- init/minio

(DNS 配置脚本)
- zone

## 服务器

### dev-base-services.geektr.co

内网机器，运行 Gitlab / Verdaccio / Docker Registry，并使用 Caddy 暴露服务

```bash
ansible-playbook --ask-vault-pass main.yml
```

### runner-01.dev-base-services.geektr.co

内网机器，运行 Gitlab Runner

```bash
ansible-playbook --ask-vault-pass gitlab_runner.yml
```

### git.router.aliyun.geektr.co

阿里云服务器，ROS，将 80 / 443 / 22 端口转发到内网

手动运行 `routeros.sh`

## 服务相关

### Verdaccio

```bash
# directly pull pkgs
npm install @geektr.co/example --registry=https://npm.geektr.co
npm install @private.geektr.co/example --registry=https://npm.geektr.co

# normal usage
npm set @geektr.co:registry https://npm.geektr.co
npm set @private.geektr.co:registry https://npm.geektr.co
npm adduser --registry https://npm.geektr.co
npm publish --registry https://npm.geektr.co

# ci enviroment
tee -a $(npm config get userconfig) <<EOF
@geektr.co:registry=https://npm.geektr.co
@private.geektr.co:registry=https://npm.geektr.co
//npm.geektr.co/:_authToken="$GNPM_AUTH_TOKEN"
EOF

# write alias in .bashrc / .zshrc
alias gnpm="npm --registry=https://npm.geektr.co \
  --cache=$HOME/.npm/.cache/gnpm \
  --userconfig=$HOME/.gnpmrc"

alias garn="yarn --registry=https://npm.geektr.co \
  --cache-folder=$HOME/.npm/.cache/garn \
  --use-yarnrc=$HOME/.garnrc"
```

### Docker registry

```bash
docker login registry.geektr.co
docker pull registry.geektr.co/alpine
docker push registry.geektr.co/alpine
```

## TODO

- [ ] 备份脚本 (to minio)
- [ ] 回滚脚本
