######### BUILDER #########
FROM golang:1.13-alpine3.10 as builder

RUN apk add --no-cache git

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo && \
    go get github.com/go-redis/redis

COPY . .

RUN go build -o /build/votingapp && \
    cp -r ui /build

######## RUNTIME #########
FROM alpine:3.10

WORKDIR /app
COPY  --from=builder /build .

ENTRYPOINT [ "./votingapp" ]
