GO_VERSION := 1.17 # or "latest" for bleeding-edge Go version
GO_BUILD_FLAGS := -x
GOCACHE ?= $(shell go env GOCACHE)
GOPATH ?= $(shell go env GOPATH)

.PHONY: build
build:
	@echo ":: Building $(shell basename $(PWD)) in MinGW container..."
	docker run --rm -it \
		-u "$${UID}:$${GID}" \
		-e GOCACHE=/go/.cache \
		-v "$(GOCACHE)":/go/.cache \
		-v "$(GOPATH)/src":/go/src \
		-v "$(GOPATH)/pkg":/go/pkg \
		-v "$(PWD)":/go/work \
		-w /go/work \
		x1unix/go-mingw:$(GO_VERSION) \
		/bin/sh -c 'go build $(GO_BUILD_FLAGS) .'
