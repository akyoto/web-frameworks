{{#language.version}}
FROM golang:{{{.}}}
{{/language.version}}
{{^language.version}}
FROM golang:1.22
{{/language.version}}

WORKDIR /go/src/app

{{#build_deps}}
  RUN apk add {{{.}}}
{{/build_deps}}

ARG ARCHITECTURE=amd64

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=$ARCHITECTURE
ENV GOAMD64=v3

{{#files}}
  COPY '{{source}}' '{{target}}'
{{/files}}

{{#bootstrap}}
  RUN {{{.}}}
{{/bootstrap}}

RUN go get
RUN go build -a -ldflags '-extldflags "-static"' {{#build_tags}} -tags {{{.}}} {{/build_tags}} -o /go/bin/app ./


FROM debian:stable

WORKDIR /go/bin

{{#environment}}
ENV {{{.}}}
{{/environment}}

COPY --from=0 /go/bin/app /go/bin/app

{{#static_files}}
  COPY '{{source}}' '{{target}}'
{{/static_files}}

CMD {{{command}}}
