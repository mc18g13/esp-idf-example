IMAGE_NAME = esp-idf-firmware-toolchain
IMAGE_VERSION = 0.1
IMAGE_USER = ${USER}
IMAGE_TAG = $(IMAGE_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)

SRC_NAME = example_project

WORKING_DIR := $(shell pwd)
REPO_SLUG := $(shell basename ${WORKING_DIR})
REPO_DIRECTORY := ${HOME}/${REPO_SLUG}
SCRIPTS_DIRECTORY := ${HOME}/${REPO_SLUG}/scripts
SOURCE_DIRECTORY := ${REPO_DIRECTORY}/${SRC_NAME}

.DEFAULT_GOAL := build

check-docker:: ## Target to check if docker is installed
	$(if $(shell which docker),,$(error "Docker needs to be installed to run this makefile"))

docker-build:: check-docker ## Build the docker image
	@echo Building $(IMAGE_TAG)
	@docker build \
		-t $(IMAGE_TAG) $(WORKING_DIR) \
		--build-arg USER=${USER} \
		--build-arg HOME=${HOME}

docker-push:: check-docker ## push the docker image
	@echo Pushing $(IMAGE_TAG)
	@docker push $(IMAGE_TAG)

DOCKER_RUN_COMMAND = 	@docker run -it \
	 --rm \
	-v ${PWD}:${REPO_DIRECTORY} \
	-w ${SOURCE_DIRECTORY} \
	--env USER=${USER} \
	--env HOME=${HOME} \
	--env SOURCE_DIRECTORY=${SOURCE_DIRECTORY} \
	$(IMAGE_TAG)

build:: ## Build the firmare
	${DOCKER_RUN_COMMAND} idf.py build

unit:: ## Run the unit tests
	${DOCKER_RUN_COMMAND} bash ${SCRIPTS_DIRECTORY}/test.sh

clean:: ## Clean build
	${DOCKER_RUN_COMMAND} idf.py fullclean

enter:: ## Enter docker image
	${DOCKER_RUN_COMMAND}

docker-print-command:: ##  Print the docker run command
	@echo ${REPO_SLUG}
	@echo ${DOCKER_RUN_COMMAND}

# A help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## This help target
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)