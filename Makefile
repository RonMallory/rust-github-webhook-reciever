build:
	cargo build

build-release:
	cargo build --release

run:
	cargo run

docker-build:
	docker build -t myapp .

docker-build-run:
	docker build -t ghwhr . && docker run -p 8000:8000 --rm -t ghwhr -n ghwhr

docker-run-sh-entrypoint:
	docker run -p 8000:8000 --rm -it --entrypoint /bin/sh myapp