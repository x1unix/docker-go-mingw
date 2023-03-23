#!/usr/bin/env bash
[ -z "$GOARCH" ] && export GOARCH=$(go env GOARCH);
[ -z "$GOOS" ] && export GOOS="windows";

# Set toolchain according to GOARCH variable
case "$GOARCH" in
    amd64)
        export CXX_FOR_TARGET=x86_64-w64-mingw32-g++
        export CC_FOR_TARGET=x86_64-w64-mingw32-gcc
        export CXX=x86_64-w64-mingw32-g++
        export CC=x86_64-w64-mingw32-gcc
        ;;
    386)
        export CXX_FOR_TARGET=i686-w64-mingw32-g++
        export CC_FOR_TARGET=i686-w64-mingw32-gcc
        export CXX=i686-w64-mingw32-g++
        export CC=i686-w64-mingw32-gcc
        ;;
    *)
        echo "Unsupported GOARCH variable value '$GOARCH'. Please set GOARCH environment variable to 'amd64' or '386'"
        exit 2
    ;;
esac

"$@"
