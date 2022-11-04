deploy: validate
	sh deploy.sh

sync: validate
	sh deploy.sh "sync"

validate:
	sam validate -t template.yaml --profile wsrodgerss

destroy:
	sam delete --stack-name sam-cloud-one-stack --profile wsrodgerss

build-HelloWorldFunction:
	sh build.sh
