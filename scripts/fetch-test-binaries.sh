#!/usr/bin/env bash
mkdir -p __main__/hack
curl -sfL https://github.com/kubernetes-sigs/kubebuilder/releases/download/v4.0.0/kubebuilder_darwin_amd64 | tar xvz --strip-components=1 -C __main__/hack