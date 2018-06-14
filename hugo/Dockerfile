# Setup Stage
FROM alpine:latest AS setup
LABEL maintainer Mike Ortiz <mike@jellydice.com>

ENV VERSION="0.42.1"
ENV RELEASE_ARCHIVE="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz"
ENV RELEASE_SHA1_HASH="070b1b28f1d9f1ab3d47bae5ff0527a8f748f757"

ADD ${RELEASE_ARCHIVE} /hugo.tar.gz

RUN apk add --no-cache --virtual outils-sha1 && \
    LOCAL_SHA1_HASH=$(sha1sum /hugo.tar.gz | awk '{print $1}') && \
    if [[ "${LOCAL_SHA1_HASH}" != "${RELEASE_SHA1_HASH}" ]]; then exit 1; fi && \
    tar -zxvf /hugo.tar.gz


# Final Stage
FROM alpine:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=setup /hugo /hugo

VOLUME /data

WORKDIR /data

ENTRYPOINT [ "/hugo" ]