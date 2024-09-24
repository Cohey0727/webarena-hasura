# VPS(WebArena Ubuntu)でDockerを使ってHasuraを起動して公開する方法

## 概要

- 概要
  - はじめに
    - SSHの設定 & 接続方法
    - システムを更新
  - ドメイン設定
    - DNSでVPSのIPにドメインを割り当て
  - nginxの設定
    - ポート80と443をDocker上のHasuraにリバースプロキシ設定
  - 公開ポートを設定 (HTTP: 80, HTTPS: 443, SSH: 22)
  - SSL証明書を取得 (Let's Encrypt)
    - certbotでSSL証明書を取得しnginxに設定
  - ファイアウォール設定
    - ポート80, 443, 22を開放
  - nginx設定ファイル (nginx.conf) を作成
    - HTTPSリクエストをHasuraコンテナにプロキシ
  - Dockerネットワークを設定
    - nginxとHasuraコンテナを同一ネットワークに設定
  - SSHの公開鍵認証を設定し、セキュリティ強化
  - Dockerをインストール
    - docker-compose.ymlを作成し、PostgreSQLとHasuraを定義
    - 作成したdocker-compose.ymlをサーバーに転送
    - `docker compose up -d`を実行してサービス起動

## はじめに

### SSHの設定 & 接続方法

`~/.ssh/config`に以下のような記述を入れる。

```config
Host webarena
  HostName xxx.xxx.xxx.xxx
  IdentityFile ~/.ssh/private_keys/webarena.Default_Key.txt
  User ubuntu
  Port 22
  TCPKeepAlive yes
```

- HostNameはIPアドレス
- IdentityFileはキーファイルのパス
- Userは`ubuntu`
- Portは`22`
- TCPKeepAliveは`yes`を指定

ターミナルで以下のコマンドでssh接続できる

```sh
ssh webarena
```

### システムを更新

以下のコマンドでシステムを更新

```sh
sudo apt update && sudo apt upgrade -y
```

## nginxの設定

### nginxをインストール

```sh
# 必要なツールをインストール
sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
```

## 公開ポートを設定

```sh
# ファイアウォールを設定
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
```

## その他

## Docker

### Docker権限

```ssh
# ubuntuユーザーをdockerグループに追加
sudo usermod -aG docker ubuntu

# グループの変更を反映させるためにセッションを再読み込み
newgrp docker

# Dockerサービスを再起動
sudo systemctl restart docker
```

ファイルの転送

```sh
scp docker-compose.yml ubuntu@webarena:/home/ubuntu/
```
