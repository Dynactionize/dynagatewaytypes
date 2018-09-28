# This repository does NOT need to live in ${GOPATH}/src/go.dynactionize.com
# It will generate code for a multitude of languages

# User overridable variables:
#
# GO_PREFIX			The path where to generate the Go code
#					Default: ${GOPATH}/src
#					Result: ${GO_PREFIX}/go.dynactionize.com/dynagatewaytypes
#
# JAVA_PREFIX		The path where to generate the Java code
#					Default: ${HOME}/java
#					Result: ${JAVA_PREFIX}/com/dynactionize/dynagatewaytypes
#
# CPP_PREFIX		The path where to generate the C++ code
#					Default: ${HOME}/cpp
#					Result ${CPP_PREFIX}/dynagatewaytypes
#
# CSHARP_PREFIX		The path where to generate the C# code
#					Default: ${HOME}/csharp
#					Result: ${CSHARP_PREFIX}/dynagatewaytypes
#
# PYTHON_PREFIX		The path where to generate the Python code
#					Default: ${HOME}/python
#					Result: ${PYTHON_PREFIX}/dynagatewaytypes
#
# NODE_PREFIX   	The path where to generate the Node.js code
#					Default: ${HOME}/node
#					Result: ${NODE_PREFIX}/dynagatewaytypes


GO_PREFIX=${GOPATH}/src
JAVA_PREFIX=${HOME}/java
CPP_PREFIX=${HOME}/cpp
CSHARP_PREFIX=${HOME}/csharp
PYTHON_PREFIX=${HOME}/python
NODE_PREFIX=${HOME}/node

PYTHON_GEN_INIT=yes

PKG_NAME := dynagatewaytypes
WD := $(shell pwd)

all: go java cpp csharp python node

clean: clean_go clean_java clean_cpp clean_csharp clean_python clean_node

distclean: clean
	-rm -rf deps


# Go generation
go: ${GOPATH}/bin/protoc-gen-go
	protoc --proto_path=$(WD)/proto \
		   --go_out=plugins=grpc:${GO_PREFIX} \
		   $(WD)/proto/dynagatewaytypes/*.proto

clean_go:
	-rm -f $(GO_PREFIX)/go.dynactionize.com/dynagatewaytypes/*.pb.go

${GOPATH}/bin/protoc-gen-go:
	go get -u github.com/golang/protobuf/protoc-gen-go	

# Java generation
java:
	-mkdir -p $(JAVA_PREFIX)

	protoc --proto_path=$(WD)/proto \
		   --java_out=$(JAVA_PREFIX) \
		   $(WD)/proto/dynagatewaytypes/*.proto

clean_java:
	-rm -rf $(JAVA_PREFIX)/com/dynactionize/dynagatewaytypes


# C++ generation
cpp: deps/grpc/bins/opt/grpc_cpp_plugin
	-mkdir -p $(CPP_PREFIX)
	
	protoc --proto_path=$(WD)/proto \
		   --cpp_out=$(CPP_PREFIX) \
		   --grpc_cpp_out=$(CPP_PREFIX) \
		   --plugin=protoc-gen-grpc_cpp=$(WD)/deps/grpc/bins/opt/grpc_cpp_plugin \
		   $(WD)/proto/dynagatewaytypes/*.proto

clean_cpp:
	-rm -rf $(CPP_PREFIX)/dynagatewaytypes

# C# generation
csharp: deps/grpc/bins/opt/grpc_csharp_plugin
	-mkdir -p $(CSHARP_PREFIX)/dynagatewaytypes

	protoc --proto_path=$(WD)/proto \
		   --csharp_out=$(CSHARP_PREFIX)/dynagatewaytypes \
		   --grpc_csharp_out=$(CSHARP_PREFIX)/dynagatewaytypes \
		   --plugin=protoc-gen-grpc_csharp=$(WD)/deps/grpc/bins/opt/grpc_csharp_plugin \
		   $(WD)/proto/dynagatewaytypes/*.proto

clean_csharp:
	-rm -rf $(CSHARP_PREFIX)/dynagatewaytypes

# Python generation
python: deps/grpc/bins/opt/grpc_python_plugin
	-mkdir -p $(PYTHON_PREFIX)/dynagatewaytypes

	protoc --proto_path=$(WD)/proto \
		   --python_out=$(PYTHON_PREFIX) \
		   --grpc_python_out=$(PYTHON_PREFIX) \
		   --plugin=protoc-gen-grpc_python=$(WD)/deps/grpc/bins/opt/grpc_python_plugin \
		   $(WD)/proto/dynagatewaytypes/*.proto

ifeq ($(PYTHON_GEN_INIT),yes)
	touch $(PYTHON_PREFIX)/dynagatewaytypes/__init__.py
endif

clean_python:
	-rm -rf $(PYTHON_PREFIX)/dynagatewaytypes

# Javascript generation
node: deps/grpc/bins/opt/grpc_node_plugin
	-mkdir -p $(NODE_PREFIX)/dynagatewaytypes

	protoc --proto_path=$(WD)/proto \
		   --js_out=import_style=commonjs,binary:$(NODE_PREFIX) \
		   --grpc_node_out=$(NODE_PREFIX) \
		   --plugin=protoc-gen-grpc_node=$(WD)/deps/grpc/bins/opt/grpc_node_plugin \
		   $(WD)/proto/dynagatewaytypes/*.proto

clean_node:
	-rm -rf $(NODE_PREFIX)/dynagatewaytypes

# gRPC Plugins
deps/grpc/bins/opt/grpc_cpp_plugin: deps/grpc/Makefile
	cd deps/grpc && make grpc_cpp_plugin

deps/grpc/bins/opt/grpc_csharp_plugin: deps/grpc/Makefile
	cd deps/grpc && make grpc_csharp_plugin

deps/grpc/bins/opt/grpc_python_plugin: deps/grpc/Makefile
	cd deps/grpc && make grpc_python_plugin

deps/grpc/bins/opt/grpc_node_plugin: deps/grpc/Makefile
	cd deps/grpc && make grpc_node_plugin

deps/grpc/Makefile:
	-mkdir -p deps
	cd deps && git clone --recursive https://github.com/grpc/grpc

