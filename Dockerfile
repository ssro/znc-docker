FROM alpine:latest

LABEL maintainer Sebastian Sasu <sebi@nologin.ro>

RUN apk add --update znc tini su-exec \
  && rm -rf /var/cache/apk/*

VOLUME ["/var/lib/znc"]

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/sbin/su-exec", "znc:znc", "znc", "--foreground", "--datadir", "/var/lib/znc"]

