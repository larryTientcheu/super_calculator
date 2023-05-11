FROM golang:1.20-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o /calculator

# This is obtained from https://hub.docker.com/r/gcriodistroless/base-debian10/tags
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /calculator /calculator

USER nonroot:nonroot

ENTRYPOINT ["/calculator"]
