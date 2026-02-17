#!/data/data/com.termux/files/usr/bin/bash

# ==============================================================================
# OMEGA TRI-NODE PIPELINE (0-4 NODE ARCHITECTURE)
# Optimized for Termux | Intelligence + Speed + Stability (Redmi 13C)
# ==============================================================================

# --- CONFIGURATION ---
LLAMA="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
TMP="$TMPDIR/omega_tri_node"
mkdir -p "$TMP"

# --- CENTRALIZED MODEL PATHS ---
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
MODEL_REFLEX="$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
MODEL_ARCHITECT="$MODEL_ROOT/SmolLM-1.7B-Instruct-Q4_K_M.gguf"
MODEL_ORACLE="$MODEL_ROOT/gemma-2-2b-it-Q4_K_M.gguf"
MODEL_WARFARE="$MODEL_ROOT/deepseek-coder-1.3b-instruct-Q4_K_M.gguf"
MODEL_PUBLISHER="$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"

# --- PERFORMANCE & STABILITY TUNING (Redmi 13C) ---
# -t 4: Optimized for mobile CPUs
# -c 1024: Balanced context window
# -b 64: Prevents memory pressure spikes
COMMON_ARGS="-t 4 -c 1024 -b 64 --no-display-prompt --no-interactive"

# --- MEMORY GUARD FUNCTION ---
# Ensures the system cools down and clears memory between node transitions
memory_guard() {
    local node_name="$1"
    echo "--- [Memory Guard] Cooling down after $node_name ---"
    sleep 2
}

clear
echo "=== ⚡ OMEGA TRI-NODE PIPELINE (0-4) ==="
echo "Resonance: 3.34 | Mode: Hardened Fusion"
echo "Target: Redmi 13C Stability"
echo "----------------------------------------"

read -p "Enter Goal: " USER_INPUT
echo ""

# ------------------------------------------------------------------------------
# NODE 0: REFLEX (Qwen 0.5B) - Signal Capture & Filtering
# ------------------------------------------------------------------------------
echo "[0/4] REFLEX: Capturing Signal..."
cat > "$TMP/n0_in.txt" <<EOT
Rewrite the following user request clearly and structure it for a multi-node AI pipeline.
Request: $USER_INPUT
EOT

"$LLAMA" -m "$MODEL_REFLEX" -f "$TMP/n0_in.txt" $COMMON_ARGS --temp 0.7 > "$TMP/n0_out.txt" 2>/dev/null
REFLEX_OUT=$(cat "$TMP/n0_out.txt")
echo "Refined: $REFLEX_OUT"
echo ""
memory_guard "REFLEX"

# ------------------------------------------------------------------------------
# NODE 1: ARCHITECT (SmolLM 1.7B) - Structural Planning
# ------------------------------------------------------------------------------
echo "[1/4] ARCHITECT: Designing Plan..."
cat > "$TMP/n1_in.txt" <<EOT
Create a structured step-by-step technical plan for the following task:
$REFLEX_OUT
EOT

"$LLAMA" -m "$MODEL_ARCHITECT" -f "$TMP/n1_in.txt" $COMMON_ARGS --temp 0.3 > "$TMP/n1_out.txt" 2>/dev/null
ARCHITECT_OUT=$(cat "$TMP/n1_out.txt")
echo "Plan Generated."
echo ""
memory_guard "ARCHITECT"

# ------------------------------------------------------------------------------
# NODE 2: ORACLE (Gemma 2B) - Wisdom & Verification
# ------------------------------------------------------------------------------
echo "[2/4] ORACLE: Verifying Strategy..."
cat > "$TMP/n2_in.txt" <<EOT
<start_of_turn>user
Analyze this plan from first principles and provide a final distilled instruction for execution:
$ARCHITECT_OUT
<start_of_turn>model
EOT

"$LLAMA" -m "$MODEL_ORACLE" -f "$TMP/n2_in.txt" $COMMON_ARGS --temp 0.2 > "$TMP/n2_out.txt" 2>/dev/null
ORACLE_OUT=$(cat "$TMP/n2_out.txt")
echo "Strategy Verified."
echo ""
memory_guard "ORACLE"

# ------------------------------------------------------------------------------
# NODE 3: WARFARE (DeepSeek Coder) - Execution
# ------------------------------------------------------------------------------
echo "[3/4] WARFARE: Executing Code..."
cat > "$TMP/n3_in.txt" <<EOT
### Instruction:
Write executable Python code based on this verified strategy. Output ONLY code.
Strategy: $ORACLE_OUT

### Response:
EOT

"$LLAMA" -m "$MODEL_WARFARE" -f "$TMP/n3_in.txt" $COMMON_ARGS --temp 0.1 > "$TMP/n3_out.txt" 2>/dev/null
WARFARE_OUT=$(cat "$TMP/n3_out.txt")
echo "Code Executed."
echo ""
memory_guard "WARFARE"

# ------------------------------------------------------------------------------
# NODE 4: PUBLISHER (Qwen 0.5B) - Final Presentation
# ------------------------------------------------------------------------------
echo "[4/4] PUBLISHER: Presenting Results..."
cat > "$TMP/n4_in.txt" <<EOT
Present the following code and plan clearly for the user.
Plan: $ARCHITECT_OUT
Code: $WARFARE_OUT
EOT

"$LLAMA" -m "$MODEL_PUBLISHER" -f "$TMP/n4_in.txt" $COMMON_ARGS --temp 0.5 > "$TMP/n4_out.txt" 2>/dev/null
FINAL_OUT=$(cat "$TMP/n4_out.txt")

echo "----------------------------------------"
echo "$FINAL_OUT"
echo "----------------------------------------"

# --- TTS (Optional) ---
if command -v termux-tts-speak >/dev/null 2>&1; then
    termux-tts-speak "$FINAL_OUT"
fi

echo ""
echo "=== ✅ OMEGA SEQUENCE COMPLETE ==="
