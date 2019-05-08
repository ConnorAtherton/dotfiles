default: help

.PHONY: test
test: ## Runs all shellcheck tests
	docker run --rm -t -w /mnt -v `pwd`:/mnt nlknguyen/alpine-shellcheck **/*.sh

help: ## Prints this help message
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {\
	printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)

