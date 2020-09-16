GO_VERSION := 1.15.2

.PHONY: win
win:
	@echo "==> Building App in MinGW container..." && \
	docker run --rm -it \
		-v "$(PWD)":/tmp/build \
		x1unix/go-mingw:$(GO_VERSION) \
		/bin/sh -c "cd /tmp/build && go build ."
