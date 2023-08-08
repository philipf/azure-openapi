# https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/csharp.md

basePath=$(realpath `pwd`/..)

docker run --rm -v "${basePath}:/local" openapitools/openapi-generator-cli generate \
    --additional-properties=netCoreProjectFile=true,packageName=MyNotes,targetFramework=net6.0 \
    -i /local/docs/my-notes-api-v1.0.0.yaml \
    -g csharp \
    -o /local/src/clients/csharp


docker run --rm -v "${basePath}:/local" openapitools/openapi-generator-cli generate \
    --additional-properties=netCoreProjectFile=true,packageName=MyNotes,targetFramework=net6.0 \
    -i /local/docs/my-notes-api-v1.0.0.yaml \
    -g typescript-angular \
    -o /local/src/clients/ng