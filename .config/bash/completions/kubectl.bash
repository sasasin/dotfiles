# https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion bash)
fi
