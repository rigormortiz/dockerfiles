# dockerfiles
## Info
Various Dockerfiles I've made that are useful.

Please see READMEs in each directory for more detailed information.

## Using the Makefile
You can build and/or push specific images using the included `Makefile`. If you're pushing these images you will want to modify the `REGISTRY_PREFIX` variable. If not, Docker will try to push to my space on dockerhub and fail.

### Usage
The `Makefile` has the following targets:
- `build` (builds an image)
- `push` (pushes an image to a registry)
- `build_and_push` (builds an image and pushes it to a registry)

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