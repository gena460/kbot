VERSION:

format:
	gofmt -s -w ./

build:
	go build -v -o kbot -ldflags "-X="github.com/gena460/kbot/cmd.appVersion=${VERSION}