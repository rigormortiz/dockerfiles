REGISTRY_PREFIX = rigormortiz

.PHONY: build push build_and_push

build_and_push: build push

build:
	@echo "[[ ===== BUILDING ${REGISTRY_PREFIX}/${image}:${version} ===== ]]"
	docker build --rm -f ${image}/Dockerfile -t ${REGISTRY_PREFIX}/${image}:${version} ${image}
	@echo "\n\n"
ifeq (${latest},yes)
	@echo "[[ ===== TAGGING ${REGISTRY_PREFIX}/${image}:${version} as latest ===== ]]"
	docker tag ${REGISTRY_PREFIX}/${image}:${version} ${REGISTRY_PREFIX}/${image}:latest
	@echo "\n\n"
endif

push:
	@echo "[[ ===== PUSHING ${REGISTRY_PREFIX}/${image}:${version} ===== ]]"
	docker push ${REGISTRY_PREFIX}/${image}:${version}
	@echo "\n\n"
ifeq (${latest},yes)
	@echo "[[ ===== PUSHING ${REGISTRY_PREFIX}/${image}:${version} as latest ===== ]]"
	docker push ${REGISTRY_PREFIX}/${image}:latest
	@echo "\n\n"
endif
