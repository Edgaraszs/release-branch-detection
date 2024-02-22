FROM alpine:latest

COPY release-branch-detection /usr/bin/release-branch-detection

ENTRYPOINT ["/usr/bin/release-branch-detection"]