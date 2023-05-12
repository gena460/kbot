# kbot
devops application from scratch

--------------------------
Commands for builds:

- make linux TARGETARCH=arm64
- make linux TARGETARCH=amd64

- make windows TARGETARCH=arm64
- make windows TARGETARCH=amd64

- make darwin TARGETARCH=arm64
- make darwin TARGETARCH=amd64

-------------------------

Commands for create image:

- make image-linux TARGETARCH=arm64
- make image-linux TARGETARCH=amd64

- make image-windows TARGETARCH=arm64
- make image-windows TARGETARCH=amd64

- make image-darwin TARGETARCH=arm64
- make image-darwin TARGETARCH=amd64

--------------------------
Commands for clean image:

- make clean-linux TARGETARCH=arm64
- make clean-linux TARGETARCH=amd64

- make clean-windows TARGETARCH=arm64
- make clean-windows TARGETARCH=amd64

- make clean-darwin TARGETARCH=arm64
- make clean-darwin TARGETARCH=amd64