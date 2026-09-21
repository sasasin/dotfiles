# https://docs.docker.com/engine/cli/completion/
if command -v docker >/dev/null 2>&1; then
    source <(docker completion bash)
fi
