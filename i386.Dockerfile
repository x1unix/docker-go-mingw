ARG GO_VERSION=1.15
FROM i386/golang:${GO_VERSION}-alpine

RUN apk add mingw-w64-binutils &&\
    apk add mingw-w64-winpthreads && \
    apk add mingw-w64-headers && \
    apk add mingw-w64-crt && \
    apk add mingw-w64-gcc && \
    apk add make
ENV PATH=/go/bin:$PATH \
    CGO_ENABLED=1 \
    GOARCH=386 \
    CXX_FOR_TARGET=i686-w64-mingw32-g++ \
    CC_FOR_TARGET=i686-w64-mingw32-gcc \
    CC=i686-w64-mingw32-gcc \
    GOOS=windows
WORKDIR /go
