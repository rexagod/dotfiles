FROM golang:latest as builder
WORKDIR /go/src/github.com/kubernetes-csi/external-snapshotter
COPY . .
RUN make build

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /go/src/github.com/kubernetes-csi/external-snapshotter/bin/snapshot-controller /usr/bin/
ENTRYPOINT ["/usr/bin/snapshot-controller"]
