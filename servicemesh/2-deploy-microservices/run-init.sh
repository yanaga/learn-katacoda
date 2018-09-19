#!/bin/bash
until (oc status &> /dev/null); do sleep 1; done

git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git fetch
git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git checkout katacoda
make -f /root/projects/istio-tutorial/Makefile istio
rm -fR /root/projects/istio-tutorial
