VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=darwin #linux windows
TARGET_ARC=arm64
APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/sartsr



format:
	gofmt -s -w ./
build_darwin: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=${shell arch} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-$(TARGET_ARC)
build_linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
test:
	go test -v
lint:
	golint
get:
	go get
image: build_darwin
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-$(TARGET_ARC)
push: image
	docker tag ${REGISTRY}/${APP}:${VERSION}-${TARGET_ARC} ${REGISTRY}/${APP}:${VERSION}-${TARGET_ARC}
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGET_ARC}
clean:
	rm -rf kbot 
	