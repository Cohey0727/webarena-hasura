FROM nginx:alpine

# envsubstコマンドは既にalpineイメージに含まれているため、追加のインストールは不要です

COPY nginx.conf.template /etc/nginx/nginx.conf.template

# 起動時にenvsubstを使用して設定ファイルを生成し、Nginxを起動
CMD ["/bin/sh", "-c", "envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]