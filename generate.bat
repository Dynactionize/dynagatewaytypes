@ECHO OFF

SET PROJECT_DIR=go.dynactionize.com\dynagatewaytypes
SET SOURCE_DIR=%GOPATH%\src\%PROJECT_DIR%

go get -u github.com/golang/protobuf/protoc-gen-go
RMDIR go /S /Q
RMDIR java /S /Q
RMDIR cpp /S /Q
RMDIR csharp /S /Q
RMDIR python /S /Q
RMDIR js /S /Q
RMDIR PHP /S /Q
RMDIR ruby /S /Q

@echo ON
protoc --proto_path=%SOURCE_DIR%\proto ^
       --go_out=plugin=grpc:%GOPATH%\src ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\java
protoc --proto_path=%SOURCE_DIR%\proto ^
       --java_out=%SOURCE_DIR%\java ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\cpp
protoc --proto_path=%SOURCE_DIR%\proto ^
       --cpp_out=%SOURCE_DIR%\cpp ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\csharp
protoc --proto_path=%SOURCE_DIR%\proto ^
       --csharp_out=%SOURCE_DIR%\csharp ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\python
protoc --proto_path=%SOURCE_DIR%\proto ^
       --python_out=%SOURCE_DIR%\python ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\js
protoc --proto_path=%SOURCE_DIR%\proto ^
       --js_out=%SOURCE_DIR%\js ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\php
protoc --proto_path=%SOURCE_DIR%\proto ^
       --php_out=%SOURCE_DIR%\php ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

MKDIR %SOURCE_DIR%\ruby
protoc --proto_path=%SOURCE_DIR%\proto ^
       --ruby_out=%SOURCE_DIR%\ruby ^
       %SOURCE_DIR%\proto\action.proto ^
       %SOURCE_DIR%\proto\authentication.proto ^
       %SOURCE_DIR%\proto\datatypes.proto ^
       %SOURCE_DIR%\proto\enums.proto ^
       %SOURCE_DIR%\proto\general_types.proto ^
       %SOURCE_DIR%\proto\instance.proto ^
       %SOURCE_DIR%\proto\labels.proto ^
       %SOURCE_DIR%\proto\query.proto ^
       %SOURCE_DIR%\proto\topology.proto

