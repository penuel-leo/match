.PHONY: all build push run dev

DOCKER_TAG ?= dsys/match:latest

export PORT ?= 8888
export ELASTICSEARCH_URL ?= elasticsearch:9200
export ELASTICSEARCH_INDEX ?= images
export ELASTICSEARCH_DOC_TYPE ?= images

all: run

build:
	docker build -t registry.ap-southeast-1.aliyuncs.com/kikitrade/image-match:1.0.0 .

push: build
	docker push registry.ap-southeast-1.aliyuncs.com/kikitrade/image-match:1.0.0

run: build
	docker run \
		-e PORT \
		-e ELASTICSEARCH_URL \
		-e ELASTICSEARCH_INDEX \
		-e ELASTICSEARCH_DOC_TYPE \
		-p $(PORT):$(PORT) \
		-it registry.ap-southeast-1.aliyuncs.com/kikitrade/image-match:1.0.0

dev: build
	docker-compose up
