FROM golang:1.15.2-alpine3.12

ENV GOCACHE /tmp

RUN apk update && \
   apk upgrade && \
   apk --no-cache add git build-base && \ 
   rm -rf /var/cache/apk/*

WORKDIR /forego

# This is here because the main repo is gathering dust
RUN go get -u github.com/yb66/forego

# Extract the binary
FROM alpine:latest
WORKDIR /forego
COPY --from=0 /go/bin/forego .

