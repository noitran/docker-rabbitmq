WORKDIR ?= ./dist
DOCKER_IMAGE ?= rabbitmq:3.8.12-alpine
IMAGE_TAG ?= noitran/rabbitmq:alpine-latest

build: clean build-fresh
.PHONY: build

build-fresh:
	set -x;
	mkdir $(WORKDIR);
	sed -e 's/%%DOCKER_IMAGE%%/$(DOCKER_IMAGE)/g' ./Dockerfile.template > $(WORKDIR)/Dockerfile
	docker build -f $(WORKDIR)/Dockerfile . -t $(IMAGE_TAG)
.PHONY: build

test:
	dgoss run -t $(IMAGE_TAG)
.PHONY: best

clean:
	if [ -d "$(WORKDIR)" ]; then \
		rm -Rf $(WORKDIR); \
	fi
.PHONY: clean

docker-push:
	docker push $(IMAGE_TAG)
.PHONY: docker-push
