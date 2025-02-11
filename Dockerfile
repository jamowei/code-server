FROM fedora:latest

ARG VERSION

COPY run.sh /app/code-server/run.sh

RUN \
  echo "**** install runtime dependencies ****" && \
  dnf update -y && \
  dnf install -y curl nano wget net-tools openssl git nodejs golang python3 && \
  echo "**** install code-server ****" && \
  CODE_RELEASE=$(echo $VERSION | sed 's|^v||') && \
  mkdir -p /app/code-server && \
  mkdir -p /workspace && \
  curl -o \
  /tmp/code-server.tar.gz -L \
  "https://github.com/coder/code-server/releases/download/v${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz" && \
  tar xf /tmp/code-server.tar.gz -C \
  /app/code-server --strip-components=1 && \
  chmod +x /app/code-server/bin/code-server /app/code-server/run.sh && \
  echo "**** clean up ****" && \
  dnf clean all && \
  rm -rf \
  /tmp/* \
  /var/tmp/*

COPY bashrc /workspace/.bashrc

EXPOSE 8080

ENTRYPOINT [ "/app/code-server/run.sh" ]