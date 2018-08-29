REGISTRY_PREFIX = rigormortiz

.PHONY: build push build_and_push

build_and_push: build push

build:
	docker build --rm -f ${image}/Dockerfile -t ${REGISTRY_PREFIX}/${image}:${version} ${image}
ifeq (${latest},yes)
	docker tag ${REGISTRY_PREFIX}/${image}:${version} ${REGISTRY_PREFIX}/${image}:latest
endif

push:
	docker push ${REGISTRY_PREFIX}/${image}:${version}
ifeq (${latest},yes)
	docker push ${REGISTRY_PREFIX}/${image}:latest
endif
