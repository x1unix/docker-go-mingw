GO_VERSION := 1.21 # or "latest" for bleeding-edge Go version
GO_BUILD_FLAGS := -x
GOCACHE ?= $(shell go env GOCACHE)
GOPATH ?= $(shell go env GOPATH)

define docker_build
@echo ":: Building for $(1) in MinGW container..."
docker run --rm -it \
	-e GOCACHE=/go/.cache \
	-e GOARCH=$(1) \
	-v "$(GOCACHE)":/go/.cache \
	-v "$(GOPATH)/src":/go/src \
	-v "$(GOPATH)/pkg":/go/pkg \
	-v "$(PWD)":/go/work \
	-w /go/work \
	x1unix/go-mingw:$(GO_VERSION) \
	go build $(GO_BUILD_FLAGS) -o hello-$(1).exe .
endef

.PHONY:all
all: build-amd64 build-i386 build-arm64

.PHONY: build-amd64 build-i386 build-arm64
build-amd64:
	$(call docker_build,amd64)

build-i386:
	$(call docker_build,386)

build-arm64:
	$(call docker_build,arm64)
