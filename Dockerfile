FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git && \
    rm -rf /var/cache/apk/*

WORKDIR /src

RUN git clone https://github.com/gin-gonic/examples.git

WORKDIR /src/examples/basic

RUN go mod init example/web && \
    go get github.com/gin-gonic/gin && \
    go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server .

FROM alpine:latest

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/server .

RUN rm -rf /var/cache/apk/*

EXPOSE 8080

USER appuser

CMD ["./server"]