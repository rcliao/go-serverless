.PHONY: clean build deploy

build: clean
	env GOOS=linux GOARCH=amd64 go build -o bin/hello cmd/hello/main.go
	env GOOS=linux GOARCH=amd64 go build -o bin/world cmd/world/main.go

zip: build
	zip bin/hello zip/hello.zip
	zip bin/world zip/world.zip

dev: build
	docker run --rm -v $(PWD):/var/task:ro,delegated lambci/lambda:go1.x bin/hello '"Hello"'

clean:
	rm -rf ./bin

deploy: clean build
	sls deploy --verbose
