FROM alpine:latest as builder
LABEL org.opencontainers.image.authors="herokukms@proton.me"
LABEL org.opencontainers.image.name="alpinevms-light"
WORKDIR /root

RUN apk add --no-cache git make build-base libcurl curl-dev openssl-dev && \
    git clone https://github.com/herokukms/alpinevms.git && \
    cd alpinevms && \
    mkdir -p bin && \
    VERBOSE=1 CC=gcc CFLAGS="-DUSE_THREADS -DFULL_INTERNAL_DATA" LDFLAGS="-lpthread -lssl -lcrypto -lcurl   "  GETIFADDRS=musl DNS_PARSER=internal make

FROM alpine:latest
COPY --from=builder /root/alpinevms/bin/vlmcsd /usr/bin/vlmcsd
COPY --from=builder /root/alpinevms/bin/vlmcs /usr/bin/vlmcs
COPY startup /usr/bin/startup
RUN chmod ugo+x /usr/bin/startup && \
    apk add --no-cache libcurl
WORKDIR /root/

EXPOSE 1688/tcp
ENTRYPOINT ["/usr/bin/startup"]
