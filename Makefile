IMG_NAME = x1unix/go-mingw

.PHONY: image image-amd64 image-i386
image: image-amd64 image-i386
image-amd64:
	@if [ -z $(GO_VERSION) ]; then echo "usage: 'make image GO_VERSION=[GO VERSION NUMBER]'" && exit 1; fi; \
	echo ":: Building amd64 image..." &&\
	docker build --platform linux/amd64 -t $(IMG_NAME):$(GO_VERSION) -f Dockerfile . --build-arg GO_VERSION=$(GO_VERSION)
image-i386:
	@if [ -z $(GO_VERSION) ]; then echo "usage: 'make image GO_VERSION=[GO VERSION NUMBER]'" && exit 1; fi; \
	echo ":: Building i386 image..." &&\
	docker build --platform linux/386 -t $(IMG_NAME)-i386:$(GO_VERSION) -f i386.Dockerfile . --build-arg GO_VERSION=$(GO_VERSION)