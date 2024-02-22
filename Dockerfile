FROM alpine:latest

COPY release-branch-detection.sh /release-branch-detection.sh

ENTRYPOINT ["/release-branch-detection.sh"]