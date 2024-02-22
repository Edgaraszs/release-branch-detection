FROM alpine:latest

COPY release-branch-detection.sh /usr/bin/release-branch-detection.sh

ENTRYPOINT ["/usr/bin/release-branch-detection.sh"]