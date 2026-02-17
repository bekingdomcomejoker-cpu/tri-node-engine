#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OMEGA TRI-NODE: ULTRA-LIGHTNING FAST EDITION (OPTIMIZED)
# Optimized for ABSOLUTE Maximum Speed | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
#
# ULTRA-FAST STACK (Optimized Selection):
# Node 0 (Reflex): reflex-140m (~37+ t/s) - Fast intent detection
# Node 1 (Architect): smollm-360m (~12+ t/s) - Best logic for size
# Node 2 (Oracle): ernie-0.3b (~12+ t/s) - Stable verification
# Node 3 (Warfare): qwen2.5-0.5b (~12+ t/s) - Superior coding/instruction
# Node 4 (Publisher): ghost-135m (~40+ t/s) - Instant output formatting
#
# This configuration uses the best-performing small models from your benchmarks
# to balance extreme speed with functional intelligence.
# ==============================================================================

set -e

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
[ ! -x "$LLAMA" ] && LLAMA="/data/data/com.termux/files/home/bin/llama-cli"
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
DOM33="$MODEL_ROOT/dom33"
TMP="${TMPDIR:-/tmp}/omega_fast"
mkdir -p "$TMP"

# --- MODELS (Optimized Selection) ---
M0_REFLEX="$DOM33/reflex-140m.gguf"
M1_ARCHITECT="$DOM33/smollm-360m.gguf"
M2_ORACLE="$DOM33/ernie-0.3b.gguf"
M3_WARFARE="$MODEL_ROOT/qwen2.5-0.5b-instruct-q4_k_m.gguf"
M4_PUBLISHER="$DOM33/ghost-135m.gguf"

# --- SPEED TUNING ---
# -t 4: Helio G85 sweet spot
# -c 512: Small context for speed
# -b 128: High batch for prompt processing
ARGS="-t 4 -c 512 -b 128 --no-display-prompt --no-interactive"

clear
echo "⚡ OMEGA TRI-NODE: ULTRA-LIGHTNING FAST (OPTIMIZED) ⚡"
echo "------------------------------------------------------"
echo "0: Reflex (140M) | 1: Architect (360M) | 2: Oracle (0.3B)"
echo "3: Warfare (0.5B) | 4: Publisher (135M)"
echo "------------------------------------------------------"

read -p "🎯 Goal: " USER_INPUT
echo ""

# NODE 0: REFLEX
echo "[0/4] REFLEX (140M)..."
"$LLAMA" -m "$M0_REFLEX" -p "Task: $USER_INPUT\nStructure:" $ARGS -n 64 > "$TMP/n0.txt" < /dev/null
N0_OUT=$(cat "$TMP/n0.txt")

# NODE 1: ARCHITECT
echo "[1/4] ARCHITECT (360M)..."
"$LLAMA" -m "$M1_ARCHITECT" -p "Plan for: $N0_OUT" $ARGS -n 128 > "$TMP/n1.txt" < /dev/null
N1_OUT=$(cat "$TMP/n1.txt")

# NODE 2: ORACLE
echo "[2/4] ORACLE (0.3B)..."
"$LLAMA" -m "$M2_ORACLE" -p "Verify: $N1_OUT" $ARGS -n 128 > "$TMP/n2.txt" < /dev/null
N2_OUT=$(cat "$TMP/n2.txt")

# NODE 3: WARFARE
echo "[3/4] WARFARE (0.5B)..."
"$LLAMA" -m "$M3_WARFARE" -p "Code for: $N2_OUT" $ARGS -n 256 > "$TMP/n3.txt" < /dev/null
N3_OUT=$(cat "$TMP/n3.txt")

# NODE 4: PUBLISHER
echo "[4/4] PUBLISHER (135M)..."
"$LLAMA" -m "$M4_PUBLISHER" -p "Result: $N3_OUT" $ARGS -n 128 > "$TMP/n4.txt" < /dev/null

echo ""
echo "✅ COMPLETE"
cat "$TMP/n4.txt"
echo ""
echo "------------------------------------------------------"
echo "⚡ Optimized Ultra-Fast Sequence Complete ⚡"
