VERSION := 0.0.1
.PHONY: build test

build:
	go build ./...

test: bin/sqlc-gen-python.wasm
	go test ./...

all: bin/sqlc-gen-python bin/sqlc-gen-python.wasm

bin/sqlc-gen-python: bin go.mod go.sum $(wildcard **/*.go)
	cd plugin && go build -o ../bin/sqlc-gen-python ./main.go

bin/sqlc-gen-python.wasm: bin/sqlc-gen-python
	cd plugin && GOOS=wasip1 GOARCH=wasm go build -o ../bin/sqlc-gen-python.wasm main.go

bin/sqlc-gen-python.wasm.sha256: bin/sqlc-gen-python.wasm
	openssl sha256 $< | awk '{print $$2}' > $@

bin:
	mkdir -p bin

.PHONY: release
release: bin/sqlc-gen-python.wasm bin/sqlc-gen-python.wasm.sha256
	gh release create "v${VERSION}" bin/sqlc-gen-python.wasm bin/sqlc-gen-python.wasm.sha256
