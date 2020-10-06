# janus-nginx-docker

Janus GatewayをDockerで動作させます。Nginxのコンテナも同時に作成します。
Janusのデモアプリケーションが動作します。

## 使い方

リポジトリのルートフォルダにサーバの秘密鍵と証明書をそれぞれ`server.key`および`server.crt`というファイル名で作成しておきます。

### コンテナ起動方法
```
$ docker-compose up -d --build
```

### 停止
```
$ docker-compose down
```