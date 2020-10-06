FROM ubuntu:18.04
LABEL maintainer="Kozo Komiya <kozo.komiya@gmail.com>"

# ツール類のインストール
RUN apt-get update \
	&& apt-get install -y wget tar git tree vim openssl gettext curl

# 依存ライブラリのインストール
RUN apt-get update \
  && apt-get install -y libmicrohttpd-dev libjansson-dev libssl-dev libsrtp-dev \
  libsofia-sip-ua-dev libglib2.0-dev libopus-dev libogg-dev libcurl4-openssl-dev \
  liblua5.3-dev libconfig-dev pkg-config gengetopt libtool automake 

# libnice最新版のインストール
RUN cd /root \
  && apt-get install -y python3-pip \
  && pip3 install meson ninja \
  && git clone https://gitlab.freedesktop.org/libnice/libnice \
  && cd libnice \
  && meson --prefix=/usr build \
  && ninja -C build \
  && ninja -C build install \
  && ldconfig 

# libstrp 2.3のインストール
RUN cd /root \
  && wget https://github.com/cisco/libsrtp/archive/v2.3.0.tar.gz \
  && tar xfv v2.3.0.tar.gz \
  && cd libsrtp-2.3.0 \
  && ./configure --prefix=/usr --enable-openssl \
  && make shared_library \
  && make install \
  && ldconfig

# usrsctpのインストール (Data Channelサポートのため)
RUN cd /root \
  && git clone https://github.com/sctplab/usrsctp \
  && cd usrsctp \
  && ./bootstrap \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && ldconfig

# install janus gateway
RUN cd /root \
  && git clone https://github.com/meetecho/janus-gateway.git -b v0.10.6\
  && cd janus-gateway \
  && sh autogen.sh \
  && ./configure --prefix=/opt/janus \
  && make \
  && make install \
  && make configs

# Janus Configuration 
COPY resources/init-janus.sh /root/init.sh 
COPY resources/janus.jcfg /opt/janus/etc/janus/janus.jcfg

# Start Janus
ENTRYPOINT ["/root/init.sh"]
