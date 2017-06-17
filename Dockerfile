FROM alpine:latest

LABEL maintainer Sebastian Sasu <sebi@nologin.ro>

ENV ZNC_VER znc-1.6.5

RUN adduser znc -D -h /var/lib/znc
RUN apk add --update ca-certificates g++ icu-dev make openssl-dev perl-dev python3-dev swig tcl-dev tini wget zlib-dev \
    && wget -O /tmp/$ZNC_VER.tar.gz http://znc.in/releases/$ZNC_VER.tar.gz \
    && tar zxf /tmp/$ZNC_VER.tar.gz \
    && cd $ZNC_VER \
    && ./configure --prefix=/usr --enable-python --enable-perl --enable-tcl \
    && make && make install && cd \
    && apk del g++ make && rm -rf /var/cache/apk/* rm -Rf /tmp/$ZNC_VER

ENTRYPOINT ["/sbin/tini", "--"]
USER znc
VOLUME ["/var/lib/znc"]
CMD ["znc", "--foreground", "--datadir", "/var/lib/znc"]
