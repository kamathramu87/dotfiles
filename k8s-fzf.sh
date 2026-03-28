#!/bin/zsh
# Kubernetes fuzzy search helpers using fzf

# Switch context
kctx() {
    local ctx
    ctx=$(kubectl config get-contexts -o name | fzf --prompt="Switch context > " --preview 'kubectl config get-contexts {}')
    [ -n "$ctx" ] && kubectl config use-context "$ctx"
}

# Switch namespace
kns() {
    local ns
    ns=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | fzf --prompt="Switch namespace > ")
    [ -n "$ns" ] && kubectl config set-context --current --namespace="$ns"
}

# Fuzzy get pods (with optional namespace flag)
kgp() {
    kubectl get pods "$@" | fzf --header-lines=1 --prompt="Select pod > "
}

# Exec into a pod
kexec() {
    local pod ns_flag=""
    [ -n "$1" ] && ns_flag="-n $1"
    pod=$(kubectl get pods $ns_flag -o wide | fzf --header-lines=1 --prompt="Exec into pod > " | awk '{print $1}')
    [ -n "$pod" ] && kubectl exec -it $ns_flag "$pod" -- /bin/sh
}

# Tail logs from a pod
klogs() {
    local pod ns_flag=""
    [ -n "$1" ] && ns_flag="-n $1"
    pod=$(kubectl get pods $ns_flag | fzf --header-lines=1 --prompt="Logs for pod > " | awk '{print $1}')
    [ -n "$pod" ] && kubectl logs -f $ns_flag "$pod"
}

# Describe any resource
kdesc() {
    local resource type
    type=$(echo -e "pod\ndeployment\nservice\nnode\nconfigmap\nsecret\ningress" | fzf --prompt="Resource type > ")
    [ -z "$type" ] && return
    resource=$(kubectl get "$type" | fzf --header-lines=1 --prompt="Select $type > " | awk '{print $1}')
    [ -n "$resource" ] && kubectl describe "$type" "$resource"
}

# Delete a pod
kdel() {
    local pod ns_flag=""
    [ -n "$1" ] && ns_flag="-n $1"
    pod=$(kubectl get pods $ns_flag | fzf --header-lines=1 --prompt="Delete pod > " | awk '{print $1}')
    [ -n "$pod" ] && kubectl delete pod $ns_flag "$pod"
}

# Port forward to a pod
kpf() {
    local pod port ns_flag=""
    [ -n "$1" ] && ns_flag="-n $1"
    pod=$(kubectl get pods $ns_flag | fzf --header-lines=1 --prompt="Port-forward pod > " | awk '{print $1}')
    [ -z "$pod" ] && return
    echo -n "Local:Remote port (e.g. 8080:80): "
    read port
    kubectl port-forward $ns_flag "$pod" "$port"
}

# Show all k8s functions
khelp() {
    echo "Kubernetes fzf helpers:"
    echo "  kctx   — switch context"
    echo "  kns    — switch namespace"
    echo "  kgp    — fuzzy get pods"
    echo "  kexec  — exec into pod"
    echo "  klogs  — tail pod logs"
    echo "  kdesc  — describe any resource"
    echo "  kdel   — delete a pod"
    echo "  kpf    — port-forward to pod"
}
