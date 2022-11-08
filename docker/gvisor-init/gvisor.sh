#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# For debugging purposes.
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Check if gVisor is configured on the node.
echo "* Checking for /host/run/containerd/runsc/config.toml file..."
if [[ -f /host/run/containerd/runsc/config.toml ]]; then
    echo "* Configuring Falco+gVisor integration".
    /usr/bin/falco --gvisor-generate-config=/run/containerd/runsc/falco.sock > /host/run/containerd/runsc/pod-init.json
    if [[ -z $(grep pod-init-config /host/run/containerd/runsc/config.toml) ]]; then
      echo '  pod-init-config = "/run/containerd/runsc/pod-init.json"' >> /host/run/containerd/runsc/config.toml
    fi
    # Endpoint inside the container is different from outside, add
    # "/host" to the endpoint path inside the container.
    sed 's/"endpoint" : "\/run/"endpoint" : "\/host\/run/' /host/run/containerd/runsc/pod-init.json > /gvisor-config/pod-init.json
else
    echo "* File /host/run/containerd/runsc/config.toml not found."
    echo "* Please make sure that the gvisor is configured in the current node."
fi
