module github.com/steled/cert-manager-webhook-duckdns

go 1.18

require (
	github.com/ebrianne/duckdns-go v1.0.3
	github.com/jetstack/cert-manager v1.7.3
	github.com/pkg/errors v0.9.1
	k8s.io/apiextensions-apiserver v0.23.1
	k8s.io/apimachinery v0.30.2
	k8s.io/client-go v0.30.2
	k8s.io/klog/v2 v2.130.1
)
