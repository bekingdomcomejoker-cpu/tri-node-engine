#!/data/data/com.termux/files/usr/bin/bash

# ==============================================================================
# OMEGA TRI-NODE: LIGHTNING FAST EDITION
# Optimized for Maximum Speed | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
# 
# FAST STACK:
# Node 0 (Reflex):    NeoX Tiny 125M (~37 t/s)
# Node 1 (Architect): Qwen 2.5 0.5B (~28 t/s)
# Node 2 (Oracle):    Qwen 2.5 0.5B (~28 t/s)
# Node 3 (Warfare):   Qwen 2.5 0.5B (~28 t/s)
# Node 4 (Publisher): NeoX Tiny 125M (~37 t/s)
#
# ==============================================================================

set -e

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
[ ! -x "$LLAMA" ] && LLAMA="/data/data/com.termux/files/home/bin/llama-cli"

MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
TMP="${TMPDIR:-/tmp}/omega_fast"
mkdir -p "$TMP"

# --- MODELS ---
# Using the absolute fastest models from benchmarks
MODEL_TINY="$MODEL_ROOT/neox-tiny-125m.gguf"
MODEL_FAST="$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"

# --- SPEED TUNING ---
# -t 4: Helio G85 sweet spot
# -c 512: Small context for speed
# -b 128: High batch for prompt processing
ARGS="-t 4 -c 512 -b 128 --no-display-prompt --no-interactive"

clear
echo "⚡ OMEGA TRI-NODE: LIGHTNING FAST ⚡"
echo "------------------------------------"

read -p "🎯 Goal: " USER_INPUT
echo ""

# NODE 0: REFLEX (Tiny)
echo "[0/4] REFLEX (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Task: $USER_INPUT\nStructure:" $ARGS -n 64 > "$TMP/n0.txt" < /dev/null
N0_OUT=$(cat "$TMP/n0.txt")

# NODE 1: ARCHITECT (Fast)
echo "[1/4] ARCHITECT (Fast)..."
"$LLAMA" -m "$MODEL_FAST" -p "Plan for: $N0_OUT" $ARGS -n 128 > "$TMP/n1.txt" < /dev/null
N1_OUT=$(cat "$TMP/n1.txt")

# NODE 2: ORACLE (Fast)
echo "[2/4] ORACLE (Fast)..."
"$LLAMA" -m "$MODEL_FAST" -p "Verify: $N1_OUT" $ARGS -n 128 > "$TMP/n2.txt" < /dev/null
N2_OUT=$(cat "$TMP/n2.txt")

# NODE 3: WARFARE (Fast)
echo "[3/4] WARFARE (Fast)..."
"$LLAMA" -m "$MODEL_FAST" -p "Code for: $N2_OUT" $ARGS -n 256 > "$TMP/n3.txt" < /dev/null
N3_OUT=$(cat "$TMP/n3.txt")

# NODE 4: PUBLISHER (Tiny)
echo "[4/4] PUBLISHER (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Result: $N3_OUT" $ARGS -n 128 > "$TMP/n4.txt" < /dev/null

echo ""
echo "✅ COMPLETE"
cat "$TMP/n4.txt"
