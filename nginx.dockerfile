FROM nginx:1.18
LABEL maintainer="Kozo Komiya <kozo.komiya@gmail.com>"

# 設定ファイルのインストール
COPY resources/default.conf /etc/nginx/conf.d/default.conf
COPY server.key /etc/nginx/conf.d/server.key 
COPY server.crt /etc/nginx/conf.d/server.crt
