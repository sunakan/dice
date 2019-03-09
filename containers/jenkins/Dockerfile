FROM jenkins/jenkins:lts-alpine

# プラグインをimage build時に入れる
# https://github.com/jenkinsci/docker#script-usage
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

# Dockerをインストール
# alpineでは無理: RUN curl -sSL https://get.docker.com/ | CHANNEL=stable sh
# 安定版のバイナリの場所
#   - https://download.docker.com/linux/static/stable/x86_64/
ENV DOCKER_VERSION 18.06.3-ce
RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/test/x86_64/docker-$DOCKER_VERSION.tgz" && \
  tar --strip-components=1 -xvzf docker.tgz -C /usr/bin

# docker-composeのインストール
# https://docs.docker.com/compose/install/#install-compose
# https://github.com/docker/compose/releases
#ENV DOCKER_COMPOSE_VERSION 1.23.2
#RUN curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#  chmod +x /usr/local/bin/docker-compose
RUN apk add py-pip && pip install docker-compose

# jenkinsユーザにDockerコマンドの権限を追加
RUN addgroup -S docker && adduser jenkins docker
