# APP_VERSION ?= v0.1.0
# IMAGE_REGISTRY ?= quay.io/opstree
# IMAGE_NAME ?= salary-api
APP_VERSION ?= 1.0
IMAGE_REGISTRY ?= us-central1-docker.pkg.dev/gowtham-demo-433405/salary-reg
IMAGE_NAME ?= salary-ms

# Build salary api
build:
	mvn clean package

# Run checkstyle against code
fmt:
	mvn checkstyle:checkstyle

# Run jacoco test cases for coverage
test:
	mvn test

docker-build:
	docker build -t ${IMAGE_REGISTRY}/${IMAGE_NAME}:${APP_VERSION} -f Dockerfile .

docker-push:
	docker push ${IMAGE_REGISTRY}/${IMAGE_NAME}:${APP_VERSION}

run-migrations:
	migrate -source file://migration -database "$(shell cat migration.json | jq -r '.database')" up
