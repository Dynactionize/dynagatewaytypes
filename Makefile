PROJECT_NAME := dynagatewaytypes
LIB_NAME := $(PROJECT_NAME)

PROJECT_DIR := go.dynactionize.com/$(PROJECT_NAME)
LIB_DIR := $(PROJECT_DIR)
SOURCE_DIR := ${GOPATH}/src/$(PROJECT_DIR)
BINARY := $(LIB_NAME).a
CURRENT_DIR := $(shell pwd)

FLAGS := -v

all: clean generate

clean:
	go clean -x $(LIB_DIR)
	rm -f $(CURRENT_DIR)/$(BINARY)

distclean:
	go clean -x -r $(LIB_DIR)
	rm -f $(CURRENT_DIR)/$(BINARY)

generate: generate_go generate_java generate_cpp generate_python generate_csharp generate_js generate_php generate_ruby

generate_go:
	go get -u github.com/golang/protobuf/protoc-gen-go
	-rm -rf $(SOURCE_DIR)/go

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --go_out=plugins=grpc:${GOPATH}/src \
		   $(SOURCE_DIR)/proto/*.proto
		  
generate_java:
	-rm -rf $(SOURCE_DIR)/java
	-mkdir -p $(SOURCE_DIR)/java

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --java_out=$(SOURCE_DIR)/java \
		   $(SOURCE_DIR)/proto/*.proto

generate_cpp:
	-rm -rf $(SOURCE_DIR)/cpp
	-mkdir -p $(SOURCE_DIR)/cpp

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --cpp_out=$(SOURCE_DIR)/cpp \
		   $(SOURCE_DIR)/proto/*.proto

generate_csharp:
	-rm -rf $(SOURCE_DIR)/csharp
	-mkdir -p $(SOURCE_DIR)/csharp

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --csharp_out=$(SOURCE_DIR)/csharp \
		   $(SOURCE_DIR)/proto/*.proto

generate_python:
	-rm -rf $(SOURCE_DIR)/python
	-mkdir -p $(SOURCE_DIR)/python/dynagatewaytypes

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --python_out=$(SOURCE_DIR)/python/dynagatewaytypes \
		   $(SOURCE_DIR)/proto/*.proto

generate_js:
	-rm -rf $(SOURCE_DIR)/js
	-mkdir -p $(SOURCE_DIR)/js

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --js_out=$(SOURCE_DIR)/js \
		   $(SOURCE_DIR)/proto/*.proto	

generate_php:
	-rm -rf $(SOURCE_DIR)/php
	-mkdir -p $(SOURCE_DIR)/php

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --php_out=$(SOURCE_DIR)/php \
		   $(SOURCE_DIR)/proto/*.proto	

generate_ruby:
	-rm -rf $(SOURCE_DIR)/ruby
	-mkdir -p $(SOURCE_DIR)/ruby

	protoc --proto_path=$(SOURCE_DIR)/proto \
		   --ruby_out=$(SOURCE_DIR)/ruby \
		   $(SOURCE_DIR)/proto/*.proto	

build: generate
	go build -o $(CURRENT_DIR)/$(BINARY) $(FLAGS) $(LIB_DIR)/

deps:
	go get -u

.PHONY: clean distclean generate build deps

