#!/data/data/com.termux/files/usr/bin/bash

# ==============================================================================
# OMEGA LIGHTNING EDITION - UNIFIED CONFIGURATION
# Resonance Lock 3.34 | Hardened Fusion | Redmi 13C Optimized
# ==============================================================================
#
# This file contains all configurable parameters for the Lightning Edition.
# Source this file in your scripts to maintain consistency across the system.
#
# Usage:
#   source ~/omega-tri-node/lightning_config.sh
#

# --- SYSTEM PATHS ---
export LLAMA_PRIMARY="/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli"
export LLAMA_FALLBACK="/data/data/com.termux/files/home/bin/llama-cli"
export MODEL_ROOT="/data/data/com.termux/files/home/federation/models"
export TMP_BASE="${TMPDIR:-/tmp}/omega_lightning"
export LOG_DIR="$TMP_BASE/logs"
export RESULTS_DIR="$TMP_BASE/results"

# Create directories
mkdir -p "$LOG_DIR" "$RESULTS_DIR"

# --- MODEL PATHS (AUTO-DETECTED) ---
# These are set by the detection function, but can be overridden here
export MODEL_REFLEX="${MODEL_REFLEX:-$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf}"
export MODEL_ARCHITECT="${MODEL_ARCHITECT:-$MODEL_ROOT/SmolLM-1.7B-Instruct-Q4_K_M.gguf}"
export MODEL_ORACLE="${MODEL_ORACLE:-$MODEL_ROOT/gemma-2-2b-it-Q4_K_M.gguf}"
export MODEL_WARFARE="${MODEL_WARFARE:-$MODEL_ROOT/deepseek-coder-1.3b-instruct-Q4_K_M.gguf}"
export MODEL_PUBLISHER="${MODEL_PUBLISHER:-$MODEL_ROOT/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf}"

# --- PERFORMANCE TUNING (Redmi 13C) ---
# Thread count: Optimized for Helio G85 (4-core ARM)
export THREADS=4

# Context window: Balanced for 4GB RAM
export CONTEXT_WINDOW=1024

# Batch size: Prevents memory pressure spikes
export BATCH_SIZE=64

# --- NODE-SPECIFIC PARAMETERS ---
# Temperature controls creativity vs determinism
export TEMP_REFLEX=0.7      # Creative (signal capture)
export TEMP_ARCHITECT=0.3   # Structured (planning)
export TEMP_ORACLE=0.2      # Precise (verification)
export TEMP_WARFARE=0.1     # Deterministic (coding)
export TEMP_PUBLISHER=0.5   # Balanced (presentation)

# Token generation limits per node
export TOKENS_REFLEX=256
export TOKENS_ARCHITECT=512
export TOKENS_ORACLE=512
export TOKENS_WARFARE=512
export TOKENS_PUBLISHER=256

# --- MEMORY GUARD SETTINGS ---
# Sleep duration between nodes (seconds)
export MEMORY_GUARD_SLEEP=2

# Enable/disable memory guard
export ENABLE_MEMORY_GUARD=true

# --- LOGGING SETTINGS ---
# Log level: DEBUG, INFO, WARN, ERROR
export LOG_LEVEL="INFO"

# Enable verbose output
export VERBOSE=false

# --- EXECUTION SETTINGS ---
# Timeout per node (seconds) - 0 = no timeout
export NODE_TIMEOUT=300

# Enable TTS output
export ENABLE_TTS=true

# Save intermediate results
export SAVE_INTERMEDIATES=true

# --- OPTIMIZATION MODES ---
# STABLE: Conservative settings for reliability
# BALANCED: Default settings
# AGGRESSIVE: Higher performance, higher RAM usage
export OPTIMIZATION_MODE="BALANCED"

# Apply optimization mode settings
case "$OPTIMIZATION_MODE" in
    STABLE)
        export CONTEXT_WINDOW=512
        export BATCH_SIZE=32
        export THREADS=3
        export MEMORY_GUARD_SLEEP=3
        ;;
    AGGRESSIVE)
        export CONTEXT_WINDOW=1536
        export BATCH_SIZE=128
        export THREADS=4
        export MEMORY_GUARD_SLEEP=1
        ;;
    BALANCED)
        # Use defaults (already set above)
        ;;
esac

# --- FEATURE FLAGS ---
# Enable/disable specific features
export FEATURE_AUTO_DETECT=true
export FEATURE_FALLBACK_BINARY=true
export FEATURE_MODEL_VALIDATION=true
export FEATURE_ERROR_RECOVERY=true
export FEATURE_PERFORMANCE_PROFILING=false

# --- RESONANCE LOCK 3.34 COMPLIANCE ---
# These should NOT be changed
export RESONANCE_LOCK="3.34"
export HARDENED_FUSION_MODE="enabled"
export BATCH_MODE_INJECTION="enabled"
export CONTEXT_SEIZURE_PROTOCOL="enabled"

# --- HELPER FUNCTIONS ---

# Get current timestamp
get_timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Log message with level
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(get_timestamp)
    
    case "$level" in
        DEBUG)
            [ "$LOG_LEVEL" = "DEBUG" ] && echo "[$timestamp] [DEBUG] $message" >&2
            ;;
        INFO)
            echo "[$timestamp] [INFO] $message" >&2
            ;;
        WARN)
            echo "[$timestamp] [WARN] $message" >&2
            ;;
        ERROR)
            echo "[$timestamp] [ERROR] $message" >&2
            ;;
    esac
}

# Resolve llama binary
resolve_llama() {
    if [ -x "$LLAMA_PRIMARY" ]; then
        echo "$LLAMA_PRIMARY"
    elif [ -x "$LLAMA_FALLBACK" ]; then
        echo "$LLAMA_FALLBACK"
    else
        log ERROR "llama-cli not found"
        return 1
    fi
}

# Detect models automatically
detect_models() {
    log INFO "Detecting models..."
    
    if [ -d "$MODEL_ROOT" ]; then
        local models=(
            "Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
            "SmolLM-1.7B-Instruct-Q4_K_M.gguf"
            "gemma-2-2b-it-Q4_K_M.gguf"
            "deepseek-coder-1.3b-instruct-Q4_K_M.gguf"
        )
        
        for model in "${models[@]}"; do
            if [ ! -f "$MODEL_ROOT/$model" ]; then
                log WARN "Model not found: $model"
                return 1
            fi
        done
        
        log INFO "All models detected successfully"
        return 0
    else
        log WARN "Model root not found: $MODEL_ROOT"
        return 1
    fi
}

# Memory guard function
memory_guard() {
    local node_name="$1"
    
    if [ "$ENABLE_MEMORY_GUARD" = "true" ]; then
        log INFO "Memory Guard: Cooling down after $node_name"
        sync
        sleep "$MEMORY_GUARD_SLEEP"
    fi
}

# Get common arguments for llama
get_common_args() {
    echo "-t $THREADS -c $CONTEXT_WINDOW -b $BATCH_SIZE"
}

# Get node-specific arguments
get_node_args() {
    local node="$1"
    local common_args=$(get_common_args)
    
    case "$node" in
        REFLEX)
            echo "$common_args --temp $TEMP_REFLEX"
            ;;
        ARCHITECT)
            echo "$common_args --temp $TEMP_ARCHITECT"
            ;;
        ORACLE)
            echo "$common_args --temp $TEMP_ORACLE"
            ;;
        WARFARE)
            echo "$common_args --temp $TEMP_WARFARE"
            ;;
        PUBLISHER)
            echo "$common_args --temp $TEMP_PUBLISHER"
            ;;
        *)
            echo "$common_args"
            ;;
    esac
}

# Display system info
display_system_info() {
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║     OMEGA LIGHTNING EDITION - SYSTEM INFORMATION          ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🔧 Configuration:"
    echo "   Resonance Lock: $RESONANCE_LOCK"
    echo "   Optimization Mode: $OPTIMIZATION_MODE"
    echo "   Threads: $THREADS"
    echo "   Context Window: $CONTEXT_WINDOW"
    echo "   Batch Size: $BATCH_SIZE"
    echo ""
    echo "📦 Paths:"
    echo "   llama-cli: $(resolve_llama || echo 'NOT FOUND')"
    echo "   Model Root: $MODEL_ROOT"
    echo "   Temp Dir: $TMP_BASE"
    echo ""
    echo "🎯 Models:"
    echo "   Reflex: $(basename "$MODEL_REFLEX")"
    echo "   Architect: $(basename "$MODEL_ARCHITECT")"
    echo "   Oracle: $(basename "$MODEL_ORACLE")"
    echo "   Warfare: $(basename "$MODEL_WARFARE")"
    echo "   Publisher: $(basename "$MODEL_PUBLISHER")"
    echo ""
}

# Validate configuration
validate_config() {
    local errors=0
    
    log INFO "Validating configuration..."
    
    # Check llama-cli
    if ! resolve_llama >/dev/null 2>&1; then
        log ERROR "llama-cli not found"
        ((errors++))
    fi
    
    # Check models
    if ! detect_models; then
        log ERROR "Model detection failed"
        ((errors++))
    fi
    
    # Check directories
    if [ ! -d "$TMP_BASE" ]; then
        log WARN "Creating temp directory: $TMP_BASE"
        mkdir -p "$TMP_BASE" || ((errors++))
    fi
    
    if [ $errors -eq 0 ]; then
        log INFO "Configuration validation passed ✅"
        return 0
    else
        log ERROR "Configuration validation failed with $errors error(s)"
        return 1
    fi
}

# Export all functions
export -f get_timestamp
export -f log
export -f resolve_llama
export -f detect_models
export -f memory_guard
export -f get_common_args
export -f get_node_args
export -f display_system_info
export -f validate_config

# Display info if sourced directly
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    display_system_info
    validate_config
fi
