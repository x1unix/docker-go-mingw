IMG_NAME = x1unix/go-mingw-test
DOCKER_OUT_TYPE=docker

.PHONY: image
image:
	@if [ -z $(GO_VERSION) ]; then echo "usage: 'make image GO_VERSION=[GO VERSION NUMBER]'" && exit 1; fi; \
	echo ":: Building image..." &&\
	docker build --output=type=$(DOCKER_OUT_TYPE) -t $(IMG_NAME):$(GO_VERSION) -f Dockerfile . --build-arg GO_VERSION=$(GO_VERSION)
