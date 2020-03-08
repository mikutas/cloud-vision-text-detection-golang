FROM golang:1.14.0-alpine as dev
RUN mkdir -p /go/src/github.com/tkms0106/
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
WORKDIR /go/src/github.com/tkms0106/cloud-vision-text-detection-golang
COPY go.mod go.sum ./
RUN go mod download

FROM dev as builder
COPY ./main.go ./main.go
RUN go build ./main.go

FROM alpine:3.11.3 as runner
COPY ./assets ./assets
COPY --from=builder /go/src/github.com/tkms0106/cloud-vision-text-detection-golang/main .
CMD ./main