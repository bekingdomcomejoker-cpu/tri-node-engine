#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OMEGA TRI-NODE: ULTRA-LIGHTNING FAST EDITION
# Optimized for ABSOLUTE Maximum Speed | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
#
# ULTRA-FAST STACK (All Nodes):
# Node 0 (Reflex): NeoX Tiny 125M (~37 t/s)
# Node 1 (Architect): NeoX Tiny 125M (~37 t/s)
# Node 2 (Oracle): NeoX Tiny 125M (~37 t/s)
# Node 3 (Warfare): NeoX Tiny 125M (~37 t/s)
# Node 4 (Publisher): NeoX Tiny 125M (~37 t/s)
#
# This configuration uses the fastest model identified in your benchmarks
# for every stage of the pipeline to achieve near-instant response times.
# ==============================================================================

set -e

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
[ ! -x "$LLAMA" ] && LLAMA="/data/data/com.termux/files/home/bin/llama-cli"
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
TMP="${TMPDIR:-/tmp}/omega_fast"
mkdir -p "$TMP"

# --- MODELS ---
# Using the absolute fastest model for all nodes
MODEL_TINY="$MODEL_ROOT/neox-tiny-125m.gguf"

# --- SPEED TUNING ---
# -t 4: Helio G85 sweet spot
# -c 512: Small context for speed
# -b 128: High batch for prompt processing
ARGS="-t 4 -c 512 -b 128 --no-display-prompt --no-interactive"

clear
echo "⚡ OMEGA TRI-NODE: ULTRA-LIGHTNING FAST ⚡"
echo "------------------------------------------"
echo "Stack: NeoX Tiny 125M (All Nodes)"
echo "------------------------------------------"

read -p "🎯 Goal: " USER_INPUT
echo ""

# NODE 0: REFLEX
echo "[0/4] REFLEX (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Task: $USER_INPUT\nStructure:" $ARGS -n 64 > "$TMP/n0.txt" < /dev/null
N0_OUT=$(cat "$TMP/n0.txt")

# NODE 1: ARCHITECT
echo "[1/4] ARCHITECT (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Plan for: $N0_OUT" $ARGS -n 128 > "$TMP/n1.txt" < /dev/null
N1_OUT=$(cat "$TMP/n1.txt")

# NODE 2: ORACLE
echo "[2/4] ORACLE (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Verify: $N1_OUT" $ARGS -n 128 > "$TMP/n2.txt" < /dev/null
N2_OUT=$(cat "$TMP/n2.txt")

# NODE 3: WARFARE
echo "[3/4] WARFARE (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Code for: $N2_OUT" $ARGS -n 256 > "$TMP/n3.txt" < /dev/null
N3_OUT=$(cat "$TMP/n3.txt")

# NODE 4: PUBLISHER
echo "[4/4] PUBLISHER (Tiny)..."
"$LLAMA" -m "$MODEL_TINY" -p "Result: $N3_OUT" $ARGS -n 128 > "$TMP/n4.txt" < /dev/null

echo ""
echo "✅ COMPLETE"
cat "$TMP/n4.txt"
echo ""
echo "------------------------------------------"
echo "⚡ Ultra-Fast Sequence Complete ⚡"
