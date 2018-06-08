# Prep Stage
FROM alpine AS prep
LABEL maintainer Mike Ortiz <mike@jellydice.com>

ENV MAJOR_VERSION="3.7"
ENV MINOR_VERSION="3.7.0"
ENV MINIROOT_ARCHIVE="http://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/armhf/alpine-minirootfs-${MINOR_VERSION}-armhf.tar.gz"
ENV MINIROOT_SHA256_HASH="7f39c55cbf9aaf77d7d008c1d631eea42d3028ea05e013212c3e3713a75e2598"
 
ADD ${MINIROOT_ARCHIVE} /alpine/miniroot.tar.gz

RUN apk add --no-cache --virtual outils-SHA256 && \
    LOCAL_SHA256_HASH=$(sha256sum /alpine/miniroot.tar.gz | awk '{print $1}') && \
    if [[ "${LOCAL_SHA256_HASH}" != "${MINIROOT_SHA256_HASH}" ]]; then exit 1; fi && \
    cd alpine && \
    tar zxf miniroot.tar.gz && \
    rm miniroot.tar.gz


# Final Stage - flatten and rebase
#   * We cannot do setup because we are building this on x86
FROM scratch
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=prep /alpine /
