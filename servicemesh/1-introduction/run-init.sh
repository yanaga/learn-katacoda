#!/bin/bash
hostname -I | tr ' ' '\n' | awk NF | awk '{print $1 " master"}' | tee -a /etc/hosts
systemctl restart dnsmasq
setenforce 0

wget -c https://github.com/istio/istio/releases/download/1.0.2/istio-1.0.2-linux.tar.gz -P /root/installation

git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git fetch
git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git checkout master

rm -rf /root/projects/* /root/temp-pom.xml /root/projects/incubator-openwhisk-devtools
until $(oc status &> /dev/null); do sleep 1; done; 

oc adm policy add-cluster-role-to-user cluster-admin admin
