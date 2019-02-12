MAJOR_VERSION ?= "1"
MINOR_VERSION ?= $$(date +%s)

.PHONY: default get-swagger swagger-to-slate build
default: get-swagger swagger-to-slate build

get-swagger:
	aws apigateway create-documentation-version --rest-api-id 2kvdc9nfze --documentation-version ${MAJOR_VERSION}.${MINOR_VERSION} --stage-name dev
	aws apigateway get-export  --rest-api-id 2kvdc9nfze --stage-name dev --export-type swagger /tmp/swagger.json

swagger-to-slate:
	widdershins /tmp/swagger.json -o ./source/index.html.md

build:
	bundle exec middleman build --clean
