# Dynizer DynaGatewayTypes

**Dynizer DynaGatewayTypes** is a [Protobuf](https://developers.google.com/protocol-buffers/) message and [gRPC](https://grpc.io/) service definition for the public interface of the [*Dynizer*](https://www.dynactionize.com/the-dynizer/)

## Introduction
The current version is v1.0.0.

Static HTML docs are generated with [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc).

## Generating docs
Run *make docs* in the root of the repository to build docs from the proto definition.
A *docs* directory will be created in the repository root that contains the static HTML docs.

## Building the messages and service
Run *make* in the root of the repository to build.

## Building the messages and service for a specific language
Run *make <language>* in the root of the repository to build for a specific language.
Available languages:
    * Go (make go)
    * Java (make java)
    * C++ (make cpp)
    * C# (make csharp)
    * Python (make python)
    * Node.js (make node)
