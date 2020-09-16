FROM maxrd2/arch-mingw

ARG GO_VERSION=1.15.2
USER root
WORKDIR /tmp
RUN echo "Downloading Go $GO_VERSION..." && \
  wget "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" -O go.tar.gz && \
  tar -xf go.tar.gz && \
  mv go /usr/local/go && \
  rm go.tar.gz && \
  mkdir -p /go
ENV PATH=/go/bin:/usr/local/go/bin:$PATH \
    GOLANG_VERSION=$GO_VERSION \
    CGO_ENABLED=1 \
    CXX_FOR_TARGET=x86_64-w64-mingw32-g++ \
    CC_FOR_TARGET=x86_64-w64-mingw32-gcc \
    CC=x86_64-w64-mingw32-gcc \
    GOPATH=/go \
    GOOS=windows
WORKDIR /go
