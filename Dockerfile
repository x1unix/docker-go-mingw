ARG GO_VERSION=1.24
FROM golang:${GO_VERSION}-trixie AS builder
ARG GO_VERSION
ARG LLVM_MINGW64_VER=20241030
ARG LLVM_MINGW_UBUNTU_REL='22.04'
ARG LLVM_MINGW64_SRC="https://github.com/mstorsjo/llvm-mingw/releases/download"
ENV LLVM_MINGW64_VER="${LLVM_MINGW64_VER}"
ENV LLVM_MINGW64_SRC="$LLVM_MINGW64_SRC"

WORKDIR /tmp
COPY --chmod=0755 scripts/setup-llvm-mingw64.sh /tmp/
RUN /tmp/setup-llvm-mingw64.sh

ARG GO_VERSION
FROM golang:${GO_VERSION}-trixie

RUN apt update &&\
    apt install \
    make mingw-w64 bash --yes
COPY --chmod=0755 scripts/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
COPY --chmod=0755 scripts/install-llvm-mingw64.sh /tmp/install-llvm-mingw64.sh 
COPY --from=builder /tmp/llvm-mingw64 /tmp/llvm-mingw64
RUN /tmp/install-llvm-mingw64.sh /tmp/llvm-mingw64 && rm -rf /tmp/*
ENV PATH=/go/bin:$PATH \
    CGO_ENABLED=1 \
    GOOS=windows
WORKDIR /go
ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh"]
