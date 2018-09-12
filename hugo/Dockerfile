# Setup Stage
FROM alpine:latest AS setup
LABEL maintainer Mike Ortiz <mike@jellydice.com>

ENV VERSION="0.48"
ENV RELEASE_ARCHIVE="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz"
ENV RELEASE_SHA256_HASH="1d26dab6445fc40aa23ecd8d49cd6fdbe8b06d722907bc97b3d32e385555b2df"

ADD ${RELEASE_ARCHIVE} /hugo.tar.gz

RUN apk add --no-cache --virtual outils-sha256 && \
    LOCAL_SHA256_HASH=$(sha256sum /hugo.tar.gz | awk '{print $1}') && \
    if [[ "${LOCAL_SHA256_HASH}" != "${RELEASE_SHA256_HASH}" ]]; then exit 1; fi && \
    tar -zxvf /hugo.tar.gz


# Final Stage
FROM alpine:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=setup /hugo /hugo

VOLUME /data

WORKDIR /data

EXPOSE 1313

ENTRYPOINT [ "/hugo" ]
