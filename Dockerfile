FROM golang:1.23.1-alpine3.20 AS build_deps

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git

WORKDIR /workspace
ENV GO111MODULE=on
ENV GOPATH="/workspace/.go"

COPY go.mod .
COPY go.sum .

RUN go mod download

FROM build_deps AS build

COPY . .

RUN CGO_ENABLED=0 go build -o webhook -ldflags '-w -extldflags "-static"' .

FROM alpine:3.20.3

RUN apk add --no-cache ca-certificates

COPY --from=build /workspace/webhook /usr/local/bin/webhook

USER nobody:nobody

ENTRYPOINT ["webhook"]
