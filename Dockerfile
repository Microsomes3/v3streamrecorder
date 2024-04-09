FROM golang:1.21.7-alpine3.19 as BulildStep

WORKDIR /STREAMCATCHER

ADD ./src /STREAMCATCHER/

RUN go mod tidy

RUN go get -d -v ./...

RUN go build -o health ./cmd/streamrecorder/

FROM alpine:latest

RUN apk update && \
    apk add --no-cache python3 py3-pip ffmpeg

RUN pip install yt-dlp==2023.12.30 --no-cache-dir --break-system-packages



WORKDIR /app


COPY --from=BulildStep /STREAMCATCHER/health /app/health
RUN chmod +x /usr/bin/yt-dlp


CMD ["/app/health"]