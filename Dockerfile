FROM golang:1.22-alpine3.19 AS build_deps

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git libcap

WORKDIR /workspace
ENV GO111MODULE=on
ENV GOPATH="/workspace/.go"

COPY go.mod .
COPY go.sum .

RUN go mod download

FROM build_deps AS build

COPY . .

RUN CGO_ENABLED=0 go build -o webhook -ldflags '-w -extldflags "-static"' .

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

COPY --from=build /usr/sbin/setcap /usr/sbin/setcap
COPY --from=build /usr/lib/libcap.so.2* /usr/lib/
COPY --from=build /workspace/webhook /usr/local/bin/webhook

RUN /usr/sbin/setcap cap_net_bind_service=+ep /usr/local/bin/webhook

USER nobody:nobody

ENTRYPOINT ["webhook"]
