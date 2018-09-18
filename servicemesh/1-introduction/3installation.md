To install Istio in the cluster, we need first to make sure that we are logged in as an `system:admin` user.

To log in the OpenShift cluster, type `oc login -u system:admin`{{execute T1}}

Now that you are logged in, it's time to extract the existing istio installation: `tar -xvzf istio-1.0.2-linux.tar.gz`{{execute T1}}

## Before the installation

Istio uses [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) like VirtualServices and DestinationRule.

To allow OpenShift/Kubernetes to understand those values, we need first to install the 'CustomResourceDefinitions' file using the command `oc apply -f istio-1.0.2/install/kubernetes/helm/istio/templates/crds.yaml`{{execute T1}}

## Continue the installation

Istio provides a file `install/kubernetes/istio-demo.yaml` that contains the definition of all objects that needs to be created in the Kubernetes cluster.

Let's apply these definitions to the cluster by executing `oc apply -f istio-1.0.2/install/kubernetes/istio-demo.yaml`{{execute T1}}

Let's apply these definitions to the cluster by executing `oc project istio-system`{{execute T1}}

`oc expose svc istio-ingressgateway
oc expose svc servicegraph
oc expose svc grafana
oc expose svc prometheus
oc expose svc tracing`{{execute T1}}
>>>>>>> Testing installation commands

After the execution, Istio objects will be created.

To watch the creation of the pods, execute `oc get pods -w -n istio-system`{{execute T1}}

Once that they are all `Running`, you can hit `CTRL+C`. This concludes this scenario.

## Add Istio to the path

Now we need to add `istioctl` to the path.

Execute `export PATH=$PATH:/root/installation/istio-1.0.2/bin/`{{execute interrupt T1}}.

Now try it. Check the version of `istioctl`. 

Execute `istioctl version`{{execute T1}}.

