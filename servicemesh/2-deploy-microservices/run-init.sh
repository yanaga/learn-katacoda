#!/bin/bash
until (oc status &> /dev/null); do sleep 1; done

rm -rf /root/projects/* /root/temp-pom.xml /root/projects/incubator-openwhisk-devtools

wget -c https://github.com/istio/istio/releases/download/1.0.2/istio-1.0.2-linux.tar.gz -P /root/installation

tar -xvzf /root/installation/istio-1.0.2-linux.tar.gz -C /root/installation

oc login -u system:admin

oc apply -f /root/installation/istio-1.0.2/install/kubernetes/helm/istio/templates/crds.yaml
oc apply -f /root/installation/istio-1.0.2/install/kubernetes/istio-demo.yaml

oc expose svc istio-ingressgateway -n istio-system
oc expose svc servicegraph -n istio-system
oc expose svc grafana -n istio-system
oc expose svc prometheus -n istio-system
oc expose svc tracing -n istio-system
