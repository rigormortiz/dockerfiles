# dockerfiles
## Info
Various Dockerfiles I've made that are useful.

Please see READMEs in each directory for more detailed information.

## Using the Makefile
You can build and/or push specific images using the included `Makefile`. If you're pushing these images you will want to modify the `REGISTRY_PREFIX` variable. If not, Docker will try to push to my space on dockerhub and fail.

I've added support for multiarch container builds. Multiarch containers work by building/pushing an image for each architecture you want to support and then tying them together with a docker manifest. In my case I care about amd64 and arm32v6 since I have intel hardware/cloud instances and raspberry pis. In this workflow that means I build and push images tagged with `amd64-${VERSION}` and `arm32v6-${VERSION}` which get tied together as `${VERSION}` with the docker manifest. Please see the example below for how to use it in the context of the Makefile. I'll blog about how it works soon.

### Usage
The `Makefile` has the following targets:
- `build` (builds an image)
- `push` (pushes an image to a registry)
- `build_and_push` (builds an image and pushes it to a registry)
- `build_multiarch` (builds an image with a specific architecture)
- `push_multiarch` (pushes an image with a specific architecture to a registry)
- `build_and_push_multiarch` (builds and pushes an image with a specific architecture to a registry)
- `manifests_multiarch` (creates a manifest for images of two or more architectures)

The `Makefile` wants to have the following variables set:
- `image` (image to build. Ex. "hugo")
- `version` (version tag. Ex. "0.42")
- `latest` (OPTIONAL - tags image as latest, too. Ex. "yes")

### Examples
#### Build the hugo image in this repository, tag it as "latest", and push to the registry

```
make build_and_push image=hugo version=0.42 latest=yes
```

#### Build the hugo image in this repository and also tag it as "latest"

```
make build image=hugo version=0.42 latest=yes
```

#### Build the hugo image in this repository without tagging it as "latest"

```
make build image=hugo version=0.42
```

#### Push the hugo image previously build (maybe after some automated testing) to the registry

```
make push image=hugo version=0.42
```

#### Build the Archlinux base image for amd64 and arm32v6 (raspberry pi) and push a manifest to the registry
```
# on an x86_64/amd64 machine
make build_and_push_multiarch image=archlinux version=2019.03.01 latest=yes arch=amd64

# on an arm32v6 machine (e.g., raspberry pi)
make build_and_push_multiarch image=archlinux version=2019.03.01 latest=yes arch=arm32v6

# on a machine with docker client "experimental" config set to "enabled"
make manifests_multiarch image=aechlinux version=2019.03.01 latest=yes
```
