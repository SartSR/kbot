VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux#linux windows
TARGETARCH=arm64#amd64
APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/sartsr
DOCKER_CONTAINERS=$(docker ps -a -q)                                                                 
DOCKER_IMAGES=$(docker images -q) 

format:
	gofmt -s -w ./
build_darwin: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
build_linux:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
build:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
test:
	go test -v
lint:
	golint
get:
	go get
image: build_darwin
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-$(TARGETARCH)
push: image
	docker tag ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
clean:
	rm -rf kbot 
	docker rmi ${REGISTRY}/${APP}:${VERSION}-$(TARGETARCH)