ARG GO_VERSION=1.15
FROM golang:${GO_VERSION}-bullseye

RUN apt update &&\
    apt install \
    make mingw-w64 bash --yes
ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENV PATH=/go/bin:$PATH \
    CGO_ENABLED=1 \
    GOOS=windows
WORKDIR /go
ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh"]
