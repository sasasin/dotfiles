#!/bin/bash -v

# ============================================================
# llama-server 起動スクリプト
# R9700 / ROCm / HIP
# Qwen3.6-35B-A3B
# llama-bench ベンチ結果に基づく最適化済み設定
# ============================================================

# --- 設定（必要に応じて変更）---
LLAMA_SERVER="llama-server.exe"
MODEL_PATH="${USERPROFILE}\.lmstudio\models\unsloth\Qwen3.6-35B-A3B-GGUF\Qwen3.6-35B-A3B-UD-Q4_K_S.gguf"
MODEL_ALIAS="qwen3.6-35b-a3b"

# ネットワーク設定
HOST="127.0.0.1"
PORT=8080
# 他
CONTEXT_SIZE=262144
BATCH_SIZE=2048
UBATCH_SIZE=1024

${LLAMA_SERVER} \
  -m "${MODEL_PATH}" \
  --alias ${MODEL_ALIAS} \
  --host "${HOST}" \
  --port ${PORT} \
  --n-gpu-layers 99 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  -c ${CONTEXT_SIZE} --ctx-size ${CONTEXT_SIZE} \
  -fa on \
  --batch-size ${BATCH_SIZE} \
  --ubatch-size ${UBATCH_SIZE} \
  -t 12 \
  -tb 12 \
  -np 1 \
  --cache-prompt \
  --cache-reuse 128 \
  --slot-prompt-similarity 0.20 \
  --reasoning on \
  --reasoning-format deepseek \
  --reasoning-budget-message "Reasoning budget reached. Stop thinking and provide the final answer now." \
  --no-context-shift \
  --temp 0.6 \
  --top-p 0.95 \
  --top-k 20 \
  --min-p 0 \
  --presence-penalty 0.5 \
  --repeat-penalty 1.0 \
  --chat-template-kwargs '{"preserve_thinking":true}' \
  --no-webui \
  --metrics \
  --jinja \
;
