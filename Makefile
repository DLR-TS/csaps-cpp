SHELL:=/bin/bash

.DEFAULT_GOAL := all

.PHONY: build sent_env clean

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
MAKEFLAGS += --no-print-directory
.EXPORT_ALL_VARIABLES:
DOCKER_BUILDKIT?=1
DOCKER_CONFIG?=


CSAPS_CPP_PROJECT="csaps-cpp"
CSAPS_CPP_VERSION="latest"
CSAPS_CPP_TAG="${CSAPS_CPP_PROJECT}:${CSAPS_CPP_VERSION}"


set_env: 
	$(eval PROJECT := ${CSAPS_CPP_PROJECT}) 
	$(eval TAG := ${CSAPS_CPP_TAG})


all: build

build: set_env
	rm -rf ${ROOT_DIR}/build
	docker build --network host --tag $(shell echo ${TAG} | tr A-Z a-z) --build-arg PROJECT=${PROJECT} .
	docker cp $$(docker create --rm $(shell echo ${TAG} | tr A-Z a-z)):/tmp/${PROJECT}/build .

clean: set_env
	rm -rf "${ROOT_DIR}/build"
	docker rm $$(docker ps -a -q --filter "ancestor=${TAG}") 2> /dev/null || true
	docker rmi $$(docker images -q ${PROJECT}) 2> /dev/null || true
