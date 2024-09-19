# VPS(Ubuntu)でDockerを使ってHasuraを起動して公開する方法

- タスク
  - nginxをインストールし設定
    - ポート80と443をDocker上のHasuraにリバースプロキシ設定
  - 公開ポートを設定 (HTTP: 80, HTTPS: 443, SSH: 22)
  - ドメイン設定
    - DNSでVPSのIPにドメインを割り当て
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
