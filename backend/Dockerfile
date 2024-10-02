FROM golang:1.23-alpine AS builder

WORKDIR /usr/local/src

RUN apk --no-cache add bash git make gcc gettext musl-dev

COPY ["app/go.mod", "app/go.sum", "./"]
RUN go mod download

COPY app ./
RUN go build -o ./bin/app cmd/app/main.go

FROM alpine AS runner

COPY --from=builder /usr/local/src/bin/app /
COPY app/config/config.yaml /config.yaml

CMD [ "/app" ]