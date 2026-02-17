#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OMEGA TRI-NODE: ULTRA-LIGHTNING FAST EDITION (ABSOLUTE MAX SPEED)
# Optimized for PHYSICAL LIMIT Speed | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
#
# ABSOLUTE MAX SPEED STACK (Highest t/s from Benchmarks):
# Node 0 (Reflex): ghost-135m (~67 t/s) - Fastest available
# Node 1 (Architect): cerebras-111m (~67 t/s) - Fastest available
# Node 2 (Oracle): ghost-135m (~67 t/s) - Fastest available
# Node 3 (Warfare): cerebras-111m (~67 t/s) - Fastest available
# Node 4 (Publisher): ghost-135m (~67 t/s) - Fastest available
#
# This configuration uses ONLY the two fastest models (~67 t/s generation)
# for every stage to achieve the absolute physical limit of the device.
# ==============================================================================

set -e

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
[ ! -x "$LLAMA" ] && LLAMA="/data/data/com.termux/files/home/bin/llama-cli"
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
DOM33="$MODEL_ROOT/dom33"
TIER2="/data/data/com.termux/files/home/models/tier2"
TMP="${TMPDIR:-/tmp}/omega_fast"
mkdir -p "$TMP"

# --- MODELS (Absolute Fastest ~67 t/s) ---
M_GHOST="$DOM33/ghost-135m.gguf"
M_CEREBRAS="$TIER2/cerebras-111m.gguf"

# --- SPEED TUNING (ABSOLUTE MAX) ---
# -t 4: Helio G85 physical core limit
# -c 256: Minimal context for maximum speed
# -b 512: Ultra-high batch for prompt processing
# --temp 0: Zero temperature for fastest deterministic output
ARGS="-t 4 -c 256 -b 512 --temp 0 --no-display-prompt --no-interactive"

clear
echo "⚡ OMEGA TRI-NODE: ABSOLUTE MAX SPEED ⚡"
echo "------------------------------------------------------"
echo "Stack: Ghost-135M & Cerebras-111M (~67 t/s All Nodes)"
echo "Tuning: 4-Thread | 256-Context | 512-Batch"
echo "------------------------------------------------------"

read -p "🎯 Goal: " USER_INPUT
echo ""

# NODE 0: REFLEX
echo "[0/4] REFLEX (Ghost 67 t/s)..."
"$LLAMA" -m "$M_GHOST" -p "Task: $USER_INPUT\nStructure:" $ARGS -n 32 > "$TMP/n0.txt" < /dev/null
N0_OUT=$(cat "$TMP/n0.txt")

# NODE 1: ARCHITECT
echo "[1/4] ARCHITECT (Cerebras 67 t/s)..."
"$LLAMA" -m "$M_CEREBRAS" -p "Plan: $N0_OUT" $ARGS -n 64 > "$TMP/n1.txt" < /dev/null
N1_OUT=$(cat "$TMP/n1.txt")

# NODE 2: ORACLE
echo "[2/4] ORACLE (Ghost 67 t/s)..."
"$LLAMA" -m "$M_GHOST" -p "Verify: $N1_OUT" $ARGS -n 64 > "$TMP/n2.txt" < /dev/null
N2_OUT=$(cat "$TMP/n2.txt")

# NODE 3: WARFARE
echo "[3/4] WARFARE (Cerebras 67 t/s)..."
"$LLAMA" -m "$M_CEREBRAS" -p "Code: $N2_OUT" $ARGS -n 128 > "$TMP/n3.txt" < /dev/null
N3_OUT=$(cat "$TMP/n3.txt")

# NODE 4: PUBLISHER
echo "[4/4] PUBLISHER (Ghost 67 t/s)..."
"$LLAMA" -m "$M_GHOST" -p "Result: $N3_OUT" $ARGS -n 64 > "$TMP/n4.txt" < /dev/null

echo ""
echo "✅ COMPLETE"
cat "$TMP/n4.txt"
echo ""
echo "------------------------------------------------------"
echo "⚡ Absolute Max Speed Sequence Complete ⚡"
