FROM docker.io/fedora:latest

ARG VERSION
ARG USER_NAME=dev
ARG USER_PASSWORD=changeit

COPY run.sh /app/code-server/run.sh

RUN passwd -l root && \
    useradd -m $USER_NAME -G wheel && \
    echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && \
    chmod 755 /home/$USER_NAME

RUN dnf update -y && \
    dnf install -y curl nano wget net-tools openssl git go-task nodejs golang python3 wasmedge && \
    ln -s /usr/bin/go-task /usr/bin/task && \
    rpm --restore shadow-utils && \
    dnf clean all && \
    rm -rf /tmp/* /var/tmp/* /var/cache /var/log/dnf*

RUN CODE_RELEASE=$(echo $VERSION | sed 's|^v||') && \
    mkdir -p /app/code-server && \
    mkdir -p /workspace && \
    curl -o \
    /tmp/code-server.tar.gz -L \
    "https://github.com/coder/code-server/releases/download/v${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz" && \
    tar xf /tmp/code-server.tar.gz -C \
    /app/code-server --strip-components=1 && \
    chmod +x /app/code-server/bin/code-server /app/code-server/run.sh

EXPOSE 8080

USER dev

WORKDIR /home/dev

ENTRYPOINT [ "/app/code-server/run.sh" ]
