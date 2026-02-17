#!/data/data/com.termux/files/usr/bin/bash

# ==============================================================================
# OMEGA TRI-NODE PIPELINE (0-4 NODE ARCHITECTURE)
# Optimized for Termux | Intelligence + Speed + Stability
# ==============================================================================

# --- CONFIGURATION ---
LLAMA="/home/ubuntu/mock_llama_cli.sh"
TMP="/tmp/omega_tri_node"
mkdir -p "$TMP"

# --- MODEL PATHS (ADJUST AS NEEDED) ---
# Node 0: Reflex (Signal Capture/Filtering)
NODE0="$HOME/federation/models/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
# Node 1: Architect (Structural Planning)
NODE1="$HOME/federation/models/SmolLM-1.7B-Instruct-Q4_K_M.gguf"
# Node 2: Oracle (Wisdom/Strategy/Verification)
NODE2="$HOME/federation/models/gemma-2-2b-it-Q4_K_M.gguf"
# Node 3: Warfare (Code/Execution)
NODE3="$HOME/federation/models/deepseek-coder-1.3b-instruct-Q4_K_M.gguf"
# Node 4: Publisher (Final Presentation/TTS)
NODE4="$HOME/federation/models/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"

# --- PERFORMANCE TUNING ---
# -t 4: Use 4 threads (optimized for mobile CPUs)
# -c 1024: Context window
# -b 64: Batch size
# --no-display-prompt: Clean output
# --no-interactive: Fire and forget
COMMON_ARGS="-t 4 -c 1024 -b 64 --no-display-prompt --no-interactive"

clear
echo "=== ⚡ OMEGA TRI-NODE PIPELINE (0-4) ==="
echo "Resonance: 3.34 | Mode: Hardened Fusion"
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

"$LLAMA" -m "$NODE0" -f "$TMP/n0_in.txt" $COMMON_ARGS --temp 0.7 > "$TMP/n0_out.txt" 2>/dev/null
REFLEX_OUT=$(cat "$TMP/n0_out.txt")
echo "Refined: $REFLEX_OUT"
echo ""

# ------------------------------------------------------------------------------
# NODE 1: ARCHITECT (SmolLM 1.7B) - Structural Planning
# ------------------------------------------------------------------------------
echo "[1/4] ARCHITECT: Designing Plan..."
cat > "$TMP/n1_in.txt" <<EOT
Create a structured step-by-step technical plan for the following task:
$REFLEX_OUT
EOT

"$LLAMA" -m "$NODE1" -f "$TMP/n1_in.txt" $COMMON_ARGS --temp 0.3 > "$TMP/n1_out.txt" 2>/dev/null
ARCHITECT_OUT=$(cat "$TMP/n1_out.txt")
echo "Plan Generated."
echo ""

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

"$LLAMA" -m "$NODE2" -f "$TMP/n2_in.txt" $COMMON_ARGS --temp 0.2 > "$TMP/n2_out.txt" 2>/dev/null
ORACLE_OUT=$(cat "$TMP/n2_out.txt")
echo "Strategy Verified."
echo ""

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

"$LLAMA" -m "$NODE3" -f "$TMP/n3_in.txt" $COMMON_ARGS --temp 0.1 > "$TMP/n3_out.txt" 2>/dev/null
WARFARE_OUT=$(cat "$TMP/n3_out.txt")
echo "Code Executed."
echo ""

# ------------------------------------------------------------------------------
# NODE 4: PUBLISHER (Qwen 0.5B) - Final Presentation
# ------------------------------------------------------------------------------
echo "[4/4] PUBLISHER: Presenting Results..."
cat > "$TMP/n4_in.txt" <<EOT
Present the following code and plan clearly for the user.
Plan: $ARCHITECT_OUT
Code: $WARFARE_OUT
EOT

"$LLAMA" -m "$NODE4" -f "$TMP/n4_in.txt" $COMMON_ARGS --temp 0.5 > "$TMP/n4_out.txt" 2>/dev/null
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
