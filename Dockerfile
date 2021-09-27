FROM golang:1.17.1-alpine AS builder

RUN apk add --no-cache git

LABEL maintainer="Gustavo Neves <neves.gustavo@gmail.com>"

WORKDIR /tmp/go-hello-app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o ./out/go-hello-app .


FROM alpine:latest
RUN apk add ca-certificates
COPY --from=builder /tmp/go-hello-app/out/go-hello-app /app/go-hello-app


CMD ["/app/go-hello-app"]

