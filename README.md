# go-mingw

[![Docker Hub](https://img.shields.io/docker/pulls/x1unix/go-mingw.svg)](https://hub.docker.com/r/x1unix/go-mingw)
[![Docker Hub](https://img.shields.io/docker/v/x1unix/go-mingw.svg?sort=semver)](https://hub.docker.com/r/x1unix/go-mingw)

Docker image for building Go binaries for **Windows** with MinGW-w64 toolchain based on official Go Docker image.

Image provides simple cross-compilation environment for windows 32 and 64bit builds.

**Supports Windows on Arm!**

## Supported Architectures

Here is a list of supported host and target architectures:

| Host Architecture   | Win x86 | Win x86-64 | Win Arm |
| ------------------- | ------- | ---------- | ------- |
| **arm64 / aarch64** | ✅      |  ✅        | ✅      |
| **amd64**           | ✅      |  ✅        | ✅      |

## Usage

You can pull Docker image with desired Go version:

```shell
docker pull x1unix/go-mingw:latest # or "1.24" for specific Go version

# Or if you prefer to use GHCR:
docker pull ghcr.io/x1unix/docker-go-mingw/go-mingw:1.24
```

> [!TIP]
> Please take a look at [examples](example/) before starting to work.

### Using on CI/CD

Examples for GitLab CI and GitHub Actions are available [here](https://github.com/x1unix/docker-go-mingw/blob/master/example/ci)

### Building Go applications inside container

Mount directory with app source and build it:

```shell
docker run --rm -it -v /YourPackageSrc:/go/work \
    -w /go/work \
    x1unix/go-mingw go build .
```

You will get compiled Windows binary.

#### Windows On Arm

Set `GOARCH=arm64` to build ARM Windows binary:

```shell
docker run --rm -it -e GOARCH=arm64 -v /YourPackageSrc:/go/work \
    -w /go/work \
    x1unix/go-mingw go build .
```

#### For 32-bit toolchain

To build a 32-bit executable, set `GOARCH=386` variable:

```shell
docker run --rm -it -e GOARCH=386 -v /YourPackageSrc:/go/work \
    -w /go/work \
    x1unix/go-mingw go build .
```

> [!TIP]
> See check project build examples [here](example).

### Go linker flags override

Go linker and compiler flags can be specified using container environment variables via `-e` option.

**Example:**

```shell
docker exec -it
    -e LDFLAGS="-linkmode external -extldflags '-static -s -w'"
    ...
```

### Output files ownership

By default, Go container starts as a *root* user. It means, that all produced files
will be owned by `root:root` user.

To set files to be owned by your current user by default, start the container with your current **uid/gid**.

Use `-u` flag to start container with different user/group id.

```shell
# Start container as other uid/gid
docker exec --rm -it -u "$UID:$GID" ...
```

> [!IMPORTANT]
> For non-root container user, it is recommended to mount your host GOPATH and GOCACHE.

### Go Build Cache

In order to speed up build times and keep Go build cache, it is recommended to mount local Go build cache directory or create a separate Docker volume for it.

**Mounting local GOPATH:**

```shell
docker run --rm -it \
    -u $UID \
    -v /YourPackageSrc:/go/work \
    -v $(go env GOCACHE):/go/cache \
    -e GOCACHE=/go/cache \
    -w /go/work \
    x1unix/go-mingw go build .
```

**Using Docker volume:**

```shell
# Create Docker volume
docker volume create go-cache

# Run container with attached volume
docker run --rm -it \
    -v /YourPackageSrc:/go/work \
    -v go-cache:/go/cache \
    -e GOCACHE=/go/cache \
    -w /go/work \
    x1unix/go-mingw go build .
```

> [!TIP]
> See [Docker volumes docs](https://docs.docker.com/storage/volumes/) for more info.

### Go modules cache

In addition to Go build cache, you may also want to mount Go modules cache 
to avoid modules re-download on each build.

To do this, mount your GOPATH or Go modules directory (`$GOPATH/pkg`).

### Building custom Docker image

Docker image can be rebuilt locally with a desired Go version:

```shell
make image GO_VERSION=1.24
```

> [!IMPORTANT]
> Replace `1.24` with desired Go version.

## Credits

* [llvm-mingw](https://github.com/mstorsjo/llvm-mingw) for Windows on Arm support.
* [mingw-w64](https://www.mingw-w64.org/) - for Windows on x86 and amd64 support.
* The Go maintainers.
