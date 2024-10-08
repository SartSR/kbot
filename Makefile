VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
#VERSION=1.0.2
TARGETOS=linux#linux windows
TARGETARCH=amd64#amd64
APP=$(shell basename $(shell git remote get-url origin))
#REGISTRY=ghcr.io/sartsr
REGISTRY=sartsr
DOCKER_CONTAINERS=$(docker ps -a -q)                                                                 
DOCKER_IMAGES=$(docker images -q) 

format:
	gofmt -s -w ./
build_darwin: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
build_linux:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
build:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/SartSR/kbot/cmd.appVersion=${VERSION}
test:
	go test -v
lint:
	golint
get:
	go get
image: 
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}
push: 
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
clean:
	rm -rf kbot 
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
