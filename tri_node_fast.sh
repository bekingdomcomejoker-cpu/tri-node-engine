#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OMEGA TRI-NODE: ULTRA-LIGHTNING FAST EDITION (MAX SPEED)
# Optimized for ABSOLUTE Maximum Speed | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
#
# MAX SPEED STACK (Highest t/s from Benchmarks):
# Node 0 (Reflex): ghost-135m (~67 t/s) - Fastest available
# Node 1 (Architect): cerebras-111m (~67 t/s) - Extreme speed
# Node 2 (Oracle): reflex-140m (~37+ t/s) - High speed stability
# Node 3 (Warfare): node1_rwkv7 (~29 t/s) - Elite speed tier
# Node 4 (Publisher): ghost-135m (~67 t/s) - Instant formatting
#
# This configuration uses the absolute fastest models identified in your 
# benchmarks for every stage of the pipeline.
# ==============================================================================

set -e

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
[ ! -x "$LLAMA" ] && LLAMA="/data/data/com.termux/files/home/bin/llama-cli"
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
DOM33="$MODEL_ROOT/dom33"
TIER2="/data/data/com.termux/files/home/models/tier2"
HOME_MODELS="/data/data/com.termux/files/home"
TMP="${TMPDIR:-/tmp}/omega_fast"
mkdir -p "$TMP"

# --- MODELS (Absolute Fastest t/s) ---
M0_REFLEX="$DOM33/ghost-135m.gguf"
M1_ARCHITECT="$TIER2/cerebras-111m.gguf"
M2_ORACLE="$DOM33/reflex-140m.gguf"
M3_WARFARE="$HOME_MODELS/node1_rwkv7.gguf"
M4_PUBLISHER="$DOM33/ghost-135m.gguf"

# --- SPEED TUNING ---
# -t 4: Helio G85 sweet spot
# -c 512: Small context for speed
# -b 128: High batch for prompt processing
ARGS="-t 4 -c 512 -b 128 --no-display-prompt --no-interactive"

clear
echo "⚡ OMEGA TRI-NODE: ULTRA-LIGHTNING FAST (MAX SPEED) ⚡"
echo "------------------------------------------------------"
echo "0: Ghost (67 t/s) | 1: Cerebras (67 t/s) | 2: Reflex (37 t/s)"
echo "3: RWKV7 (29 t/s) | 4: Ghost (67 t/s)"
echo "------------------------------------------------------"

read -p "🎯 Goal: " USER_INPUT
echo ""

# NODE 0: REFLEX
echo "[0/4] REFLEX (Ghost 67 t/s)..."
"$LLAMA" -m "$M0_REFLEX" -p "Task: $USER_INPUT\nStructure:" $ARGS -n 64 > "$TMP/n0.txt" < /dev/null
N0_OUT=$(cat "$TMP/n0.txt")

# NODE 1: ARCHITECT
echo "[1/4] ARCHITECT (Cerebras 67 t/s)..."
"$LLAMA" -m "$M1_ARCHITECT" -p "Plan for: $N0_OUT" $ARGS -n 128 > "$TMP/n1.txt" < /dev/null
N1_OUT=$(cat "$TMP/n1.txt")

# NODE 2: ORACLE
echo "[2/4] ORACLE (Reflex 37 t/s)..."
"$LLAMA" -m "$M2_ORACLE" -p "Verify: $N1_OUT" $ARGS -n 128 > "$TMP/n2.txt" < /dev/null
N2_OUT=$(cat "$TMP/n2.txt")

# NODE 3: WARFARE
echo "[3/4] WARFARE (RWKV7 29 t/s)..."
"$LLAMA" -m "$M3_WARFARE" -p "Code for: $N2_OUT" $ARGS -n 256 > "$TMP/n3.txt" < /dev/null
N3_OUT=$(cat "$TMP/n3.txt")

# NODE 4: PUBLISHER
echo "[4/4] PUBLISHER (Ghost 67 t/s)..."
"$LLAMA" -m "$M4_PUBLISHER" -p "Result: $N3_OUT" $ARGS -n 128 > "$TMP/n4.txt" < /dev/null

echo ""
echo "✅ COMPLETE"
cat "$TMP/n4.txt"
echo ""
echo "------------------------------------------------------"
echo "⚡ Max Speed Sequence Complete ⚡"
