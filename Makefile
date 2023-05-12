APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := gena460
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux #linux darwin windows
TARGETARCH=amd64 #amd64 arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
#	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}

linux: format get
#command "make linux TARGETARCH=arm64 or amd64"
	echo "Compiling for linux"
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}

darwin: format get
#command "make darwin TARGETARCH=arm64 or amd64"
	echo "Compiling for arm"
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}

windows: format get
#command "make windows TARGETARCH=arm64 or amd64"
	echo "Compiling for windows"
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
#	docker build . -t ${TARGETOS} ${TARGETARCH}

image-linux:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

image-windows:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

image-darwin:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean-linux:
	rm -rf kbot
#	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	docker images --filter=reference=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} -q | xargs -r docker rmi -f

clean-windows:
	rm -rf kbot
#	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	docker images --filter=reference=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} -q | xargs -r docker rmi -f

clean-darwin:
	rm -rf kbot
#	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	docker images --filter=reference=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} -q | xargs -r docker rmi -f