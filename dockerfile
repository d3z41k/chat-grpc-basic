FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /chat-grpc-basic
RUN mkdir -p /chat-grpc-basic/proto

WORKDIR /chat-grpc-basic

COPY ./proto/service.pb.go /chat-grpc-basic/proto
COPY ./main.go /chat-grpc-basic

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o chat-grpc-basic .

CMD ./chat-grpc-basic