# Setup Stage
FROM alpine:latest AS setup
LABEL maintainer Mike Ortiz <mike@jellydice.com>

ENV VERSION="0.43"
ENV RELEASE_ARCHIVE="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz"
ENV RELEASE_SHA256_HASH="1be61308911461acfeb51d1858b46ed0b45d8bf78d06c0ac9779b5ee68c843a3"

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