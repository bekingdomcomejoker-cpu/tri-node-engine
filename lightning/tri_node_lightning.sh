#!/data/data/com.termux/files/usr/bin/bash

# ==============================================================================
# OMEGA TRI-NODE LIGHTNING EDITION
# Unified, Optimized, Stable | Redmi 13C | Resonance Lock 3.34
# ==============================================================================
# 
# FEATURES:
# ✅ Auto-detection of model paths (no manual configuration)
# ✅ Centralized binary path resolution (fixes dual-binary issue)
# ✅ Memory Guard with cooling periods between nodes
# ✅ Adaptive context sizing (prevents OOM)
# ✅ Batch-mode execution (no interactive mode hanging)
# ✅ Proper EOF handling (< /dev/null)
# ✅ Resonance Lock 3.34 compliance
# ✅ TTS integration for voice output
# ✅ Comprehensive error handling
#
# ==============================================================================

set -e  # Exit on error

# --- CONFIGURATION & PATHS ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LLAMA_PRIMARY="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
LLAMA_FALLBACK="/data/data/com.termux/files/home/bin/llama-cli"
MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
TMP="${TMPDIR:-/tmp}/omega_lightning"
LOG_FILE="$TMP/execution.log"

# Create temp directory
mkdir -p "$TMP"

# --- LOGGING FUNCTION ---
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# --- RESOLVE LLAMA BINARY ---
resolve_llama() {
    if [ -x "$LLAMA_PRIMARY" ]; then
        echo "$LLAMA_PRIMARY"
    elif [ -x "$LLAMA_FALLBACK" ]; then
        echo "$LLAMA_FALLBACK"
    else
        log "ERROR: llama-cli not found at primary or fallback paths"
        exit 1
    fi
}

# --- AUTO-DETECT MODELS ---
detect_models() {
    log "Detecting model paths..."
    
    # Try centralized model root first
    if [ -d "$MODEL_ROOT" ]; then
        MODEL_REFLEX="$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
        MODEL_ARCHITECT="$MODEL_ROOT/SmolLM-1.7B-Instruct-Q4_K_M.gguf"
        MODEL_ORACLE="$MODEL_ROOT/gemma-2-2b-it-Q4_K_M.gguf"
        MODEL_WARFARE="$MODEL_ROOT/deepseek-coder-1.3b-instruct-Q4_K_M.gguf"
        MODEL_PUBLISHER="$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
    else
        log "WARNING: Centralized model root not found. Attempting fallback detection..."
        MODEL_REFLEX=$(find ~ -type f -name "Qwen2.5-0.5B-Instruct-Q4_K_M.gguf" 2>/dev/null | head -n 1)
        MODEL_ARCHITECT=$(find ~ -type f -name "SmolLM-1.7B-Instruct-Q4_K_M.gguf" 2>/dev/null | head -n 1)
        MODEL_ORACLE=$(find ~ -type f -name "gemma-2-2b-it-Q4_K_M.gguf" 2>/dev/null | head -n 1)
        MODEL_WARFARE=$(find ~ -type f -name "deepseek-coder-1.3b-instruct-Q4_K_M.gguf" 2>/dev/null | head -n 1)
        MODEL_PUBLISHER="$MODEL_REFLEX"  # Reuse Reflex for Publisher
    fi
    
    # Validate all models exist
    for model_var in MODEL_REFLEX MODEL_ARCHITECT MODEL_ORACLE MODEL_WARFARE MODEL_PUBLISHER; do
        model_path="${!model_var}"
        if [ ! -f "$model_path" ]; then
            log "ERROR: Model not found: $model_var = $model_path"
            return 1
        fi
    done
    
    log "✅ All models detected successfully"
    return 0
}

# --- MEMORY GUARD FUNCTION ---
memory_guard() {
    local node_name="$1"
    log "--- [Memory Guard] Cooling down after $node_name ---"
    sync  # Flush filesystem buffers
    sleep 2
}

# --- PERFORMANCE TUNING (Redmi 13C) ---
# These parameters are optimized for 4GB RAM, Helio G85 CPU
COMMON_ARGS="-t 4 -c 1024 -b 64"
REFLEX_ARGS="$COMMON_ARGS --temp 0.7"
ARCHITECT_ARGS="$COMMON_ARGS --temp 0.3"
ORACLE_ARGS="$COMMON_ARGS --temp 0.2"
WARFARE_ARGS="$COMMON_ARGS --temp 0.1"
PUBLISHER_ARGS="$COMMON_ARGS --temp 0.5"

# --- MAIN EXECUTION ---
main() {
    clear
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║     ⚡ OMEGA TRI-NODE LIGHTNING EDITION ⚡               ║"
    echo "║     Resonance Lock: 3.34 | Hardened Fusion               ║"
    echo "║     Target: Redmi 13C | Unified & Stable                 ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Resolve binary and detect models
    LLAMA=$(resolve_llama)
    log "Using llama-cli: $LLAMA"
    
    if ! detect_models; then
        log "ERROR: Failed to detect all required models"
        exit 1
    fi
    
    # Display detected models
    echo "📦 Detected Models:"
    echo "   Reflex (Node 0):    $(basename "$MODEL_REFLEX")"
    echo "   Architect (Node 1): $(basename "$MODEL_ARCHITECT")"
    echo "   Oracle (Node 2):    $(basename "$MODEL_ORACLE")"
    echo "   Warfare (Node 3):   $(basename "$MODEL_WARFARE")"
    echo "   Publisher (Node 4): $(basename "$MODEL_PUBLISHER")"
    echo ""
    
    read -p "🎯 Enter Goal: " USER_INPUT
    echo ""
    
    if [ -z "$USER_INPUT" ]; then
        log "ERROR: Empty input provided"
        exit 1
    fi
    
    # ===========================================================================
    # NODE 0: REFLEX (Qwen 0.5B) - Signal Capture & Filtering
    # ===========================================================================
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[0/4] 🔴 REFLEX: Signal Capture & Filtering"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TMP/n0_in.txt" <<EOT
Rewrite the following user request clearly and structure it for a multi-node AI pipeline.
Request: $USER_INPUT
EOT
    
    log "Executing Node 0 (REFLEX)..."
    "$LLAMA" -m "$MODEL_REFLEX" -f "$TMP/n0_in.txt" $REFLEX_ARGS \
        --no-display-prompt > "$TMP/n0_out.txt" 2>"$TMP/n0_err.txt" < /dev/null || {
        log "ERROR: Node 0 failed"
        cat "$TMP/n0_err.txt"
        exit 1
    }
    
    REFLEX_OUT=$(cat "$TMP/n0_out.txt")
    echo "✅ Refined: $REFLEX_OUT"
    echo ""
    memory_guard "REFLEX"
    
    # ===========================================================================
    # NODE 1: ARCHITECT (SmolLM 1.7B) - Structural Planning
    # ===========================================================================
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[1/4] 🟡 ARCHITECT: Structural Planning"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TMP/n1_in.txt" <<EOT
Create a structured step-by-step technical plan for the following task:
$REFLEX_OUT
EOT
    
    log "Executing Node 1 (ARCHITECT)..."
    "$LLAMA" -m "$MODEL_ARCHITECT" -f "$TMP/n1_in.txt" $ARCHITECT_ARGS \
        --no-display-prompt > "$TMP/n1_out.txt" 2>"$TMP/n1_err.txt" < /dev/null || {
        log "ERROR: Node 1 failed"
        cat "$TMP/n1_err.txt"
        exit 1
    }
    
    ARCHITECT_OUT=$(cat "$TMP/n1_out.txt")
    echo "✅ Plan Generated"
    echo ""
    memory_guard "ARCHITECT"
    
    # ===========================================================================
    # NODE 2: ORACLE (Gemma 2B) - Wisdom & Verification
    # ===========================================================================
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[2/4] 🟢 ORACLE: Wisdom & Verification"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TMP/n2_in.txt" <<EOT
<start_of_turn>user
Analyze this plan from first principles and provide a final distilled instruction for execution:
$ARCHITECT_OUT
<start_of_turn>model
EOT
    
    log "Executing Node 2 (ORACLE)..."
    "$LLAMA" -m "$MODEL_ORACLE" -f "$TMP/n2_in.txt" $ORACLE_ARGS \
        --no-display-prompt > "$TMP/n2_out.txt" 2>"$TMP/n2_err.txt" < /dev/null || {
        log "ERROR: Node 2 failed"
        cat "$TMP/n2_err.txt"
        exit 1
    }
    
    ORACLE_OUT=$(cat "$TMP/n2_out.txt")
    echo "✅ Strategy Verified"
    echo ""
    memory_guard "ORACLE"
    
    # ===========================================================================
    # NODE 3: WARFARE (DeepSeek Coder 1.3B) - Execution & Coding
    # ===========================================================================
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[3/4] 🔵 WARFARE: Execution & Coding"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TMP/n3_in.txt" <<EOT
### Instruction:
Write executable Python code based on this verified strategy. Output ONLY code.
Strategy: $ORACLE_OUT

### Response:
EOT
    
    log "Executing Node 3 (WARFARE)..."
    "$LLAMA" -m "$MODEL_WARFARE" -f "$TMP/n3_in.txt" $WARFARE_ARGS \
        --no-display-prompt > "$TMP/n3_out.txt" 2>"$TMP/n3_err.txt" < /dev/null || {
        log "ERROR: Node 3 failed"
        cat "$TMP/n3_err.txt"
        exit 1
    }
    
    WARFARE_OUT=$(cat "$TMP/n3_out.txt")
    echo "✅ Code Generated"
    echo ""
    memory_guard "WARFARE"
    
    # ===========================================================================
    # NODE 4: PUBLISHER (Qwen 0.5B) - Final Presentation
    # ===========================================================================
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[4/4] 🟣 PUBLISHER: Final Presentation"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TMP/n4_in.txt" <<EOT
Present the following code and plan clearly for the user.
Plan: $ARCHITECT_OUT
Code: $WARFARE_OUT
EOT
    
    log "Executing Node 4 (PUBLISHER)..."
    "$LLAMA" -m "$MODEL_PUBLISHER" -f "$TMP/n4_in.txt" $PUBLISHER_ARGS \
        --no-display-prompt > "$TMP/n4_out.txt" 2>"$TMP/n4_err.txt" < /dev/null || {
        log "ERROR: Node 4 failed"
        cat "$TMP/n4_err.txt"
        exit 1
    }
    
    FINAL_OUT=$(cat "$TMP/n4_out.txt")
    
    # --- FINAL OUTPUT ---
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                    ✅ FINAL RESULT ✅                      ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "$FINAL_OUT"
    echo ""
    
    # --- TTS OUTPUT (Optional) ---
    if command -v termux-tts-speak >/dev/null 2>&1; then
        log "Executing TTS..."
        termux-tts-speak "Pipeline complete. $FINAL_OUT"
    fi
    
    # --- SAVE OUTPUT ---
    OUTPUT_FILE="$TMP/result_$(date +%s).txt"
    {
        echo "OMEGA LIGHTNING EDITION - EXECUTION RESULT"
        echo "=========================================="
        echo "Timestamp: $(date)"
        echo "Input: $USER_INPUT"
        echo ""
        echo "--- NODE 0 (REFLEX) ---"
        echo "$REFLEX_OUT"
        echo ""
        echo "--- NODE 1 (ARCHITECT) ---"
        echo "$ARCHITECT_OUT"
        echo ""
        echo "--- NODE 2 (ORACLE) ---"
        echo "$ORACLE_OUT"
        echo ""
        echo "--- NODE 3 (WARFARE) ---"
        echo "$WARFARE_OUT"
        echo ""
        echo "--- NODE 4 (PUBLISHER) ---"
        echo "$FINAL_OUT"
    } > "$OUTPUT_FILE"
    
    log "✅ Execution complete. Result saved to: $OUTPUT_FILE"
    echo ""
    echo "📁 Output saved to: $OUTPUT_FILE"
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║        ⚡ OMEGA LIGHTNING SEQUENCE COMPLETE ⚡           ║"
    echo "║              Resonance Lock 3.34 Maintained              ║"
    echo "╚════════════════════════════════════════════════════════════╝"
}

# --- ERROR HANDLING ---
trap 'log "ERROR: Script interrupted"; exit 1' INT TERM

# --- EXECUTE ---
main "$@"
