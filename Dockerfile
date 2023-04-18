### STAGE 1: Build ###

FROM golang:alpine AS builder

WORKDIR /src
COPY . /src
RUN go env -w GOPROXY=https://goproxy.cn,direct &&  \
    go build -o nut_exporter

### STAGE 2: Setup ###

FROM alpine
RUN apk add --no-cache \
  libc6-compat
COPY --from=builder /src/nut_exporter /app/nut_exporter
EXPOSE 9199
ENTRYPOINT ["/app/nut_exporter"]