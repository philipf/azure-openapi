# https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/csharp.md

basePath=$(realpath `pwd`/..)

docker run --rm -v "${basePath}:/local" openapitools/openapi-generator-cli generate \
    --additional-properties=azureFunctionsVersion=v4,netCoreVersion=6.0 \
    -i /local/docs/my-notes-api-v1.0.0.yaml \
    -g csharp-functions \
    -o /local/src/server

