REGISTRY_PREFIX = rigormortiz

.PHONY: build push build_and_push build_multiarch push_multiarch manifests_multiarch build_and_push_multiarch 

build_and_push: build push
build_and_push_multiarch: build_multiarch push_multiarch

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

build_multiarch:
	@echo "[[ ===== BUILDING ${REGISTRY_PREFIX}/${image}:${version} for ${arch} ===== ]]"
	docker build --rm -f ${image}/Dockerfile.${arch} -t ${REGISTRY_PREFIX}/${image}:${arch}-${version} ${image}
	@echo "\n\n"
ifeq (${latest},yes)
	@echo "[[ ===== TAGGING ${REGISTRY_PREFIX}/${image}:${version} as latest for ${arch} ===== ]]"
	docker tag ${REGISTRY_PREFIX}/${image}:${arch}-${version} ${REGISTRY_PREFIX}/${image}:${arch}-latest
	@echo "\n\n"
endif

push_multiarch:
	@echo "[[ ===== PUSHING ${REGISTRY_PREFIX}/${image}:${arch}-${version} ===== ]]"
	docker push ${REGISTRY_PREFIX}/${image}:${arch}-${version}
	@echo "\n\n"
ifeq (${latest},yes)
	@echo "[[ ===== PUSHING ${REGISTRY_PREFIX}/${image}:${arch}-${version} as ${arch}-latest ===== ]]"
	docker push ${REGISTRY_PREFIX}/${image}:${arch}-latest
	@echo "\n\n"
endif

manifests_multiarch:
	@echo "[[ ===== CREATING MANIFESTS ${REGISTRY_PREFIX}/${image}:${version} ===== ]]"
	docker manifest create --amend ${REGISTRY_PREFIX}/${image}:${version} ${REGISTRY_PREFIX}/${image}:amd64-${version} ${REGISTRY_PREFIX}/${image}:arm32v6-${version}
	docker manifest annotate ${REGISTRY_PREFIX}/${image}:${version} ${REGISTRY_PREFIX}/${image}:arm32v6-${version} --os linux --arch arm
	docker manifest push ${REGISTRY_PREFIX}/${image}:${version}
	@echo "\n\n"
ifeq (${latest},yes)
	@echo "[[ ===== CREATING MANIFESTS ${REGISTRY_PREFIX}/${image}:latest ===== ]]"
	docker manifest create --amend ${REGISTRY_PREFIX}/${image}:latest ${REGISTRY_PREFIX}/${image}:amd64-latest ${REGISTRY_PREFIX}/${image}:arm32v6-latest
	docker manifest annotate ${REGISTRY_PREFIX}/${image}:latest ${REGISTRY_PREFIX}/${image}:arm32v6-latest --os linux --arch arm
	docker manifest push ${REGISTRY_PREFIX}/${image}:latest
	@echo "\n\n"
endif