IMG_NAME = x1unix/go-mingw

.PHONY: image
image:
	@if [ -z $(GO_VERSION) ]; then echo "usage: 'make image GO_VERSION=[GO VERSION NUMBER]'" && exit 1; fi; \
	docker build -t x1unix/go-mingw:$(GO_VERSION) -f Dockerfile . --build-arg GO_VERSION=$(GO_VERSION)
