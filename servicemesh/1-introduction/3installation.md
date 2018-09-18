To install Istio in the cluster, we need first to make sure that we are logged in as an `system:admin` user.

To log in the OpenShift cluster, type `oc login -u system:admin`{{execute T1}}

Now that you are logged in, it's time to extract the existing istio installation: `tar -xvzf istio-1.0.2-linux.tar.gz`{{execute T1}}

## Before the installation

Istio uses [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) like VirtualServices and DestinationRule.

To allow OpenShift/Kubernetes to understand those values, we need first to install the 'CustomResourceDefinitions' file using the command `oc apply -f istio-1.0.2/install/kubernetes/helm/istio/templates/crds.yaml`{{execute T1}}

*"OpenShift provides security context constraints (SCC) that control the actions that a pod can perform and what it has the ability to access."*

Because of SCC, we need to allow the Istio service account to execute images with any user id.
There's a SCC called `anyuid` that needs to be associated with Istio service accounts.

Execute the following commands

`
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-galley-service-account -n istio-system
`{{execute T1}}

To understand more about SCC, we recommend you to read [Understanding Service Accounts and SCCs](https://blog.openshift.com/understanding-service-accounts-sccs/)

## Continue the installation

Istio provides a file `install/kubernetes/istio-demo.yaml` that contains the definition of all objects that needs to be created in the Kubernetes cluster.

Let's apply these definitions to the cluster by executing `oc apply -f istio-1.0.2/install/kubernetes/istio-demo.yaml`{{execute T1}}

After the execution, Istio objects will be created.

To watch the creation of the pods, execute `oc get pods -w -n istio-system`{{execute T1}}

Once that they are all `Running`, you can hit `CTRL+C`. This concludes this scenario.

## Add Istio to the path

Now we need to add `istioctl` to the path.

Execute `export PATH=$PATH:/root/installation/istio-1.0.2/bin/`{{execute interrupt T1}}.

Now try it. Check the version of `istioctl`. 

Execute `istioctl version`{{execute T1}}.

