# Setup Stage
FROM alpine:latest AS setup
LABEL maintainer Mike Ortiz <mike@jellydice.com>

ENV VERSION="1.42"
ENV RELEASE_ARCHIVE="https://downloads.rclone.org/v${VERSION}/rclone-v${VERSION}-linux-amd64.zip"

ADD ${RELEASE_ARCHIVE} /rclone.zip

RUN apk add --no-cache --virtual unzip && \
    unzip /rclone.zip && \
    mv /rclone-v${VERSION}-linux-amd64/rclone /rclone

# Final Stage
FROM alpine:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=setup /rclone /rclone
COPY get_facl.sh /get_facl.sh
COPY set_facl.sh /set_facl.sh

RUN apk add --no-cache ca-certificates acl

ENTRYPOINT [ "/rclone" ]