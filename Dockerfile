FROM alpine:latest

RUN apk add --no-cache bash curl jq

COPY release-branch-detection.sh /usr/local/bin/release-branch-detection.sh

ENTRYPOINT ["/usr/local/bin/release-branch-detection.sh"]