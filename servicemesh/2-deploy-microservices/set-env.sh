/usr/local/bin/launch.sh
until $(oc get project istio-system &> /dev/null); do sleep 1; done
export PATH=$PATH:/root/installation/istio-1.0.2/bin/
mkdir -p ~/projects && cd ~/projects
