# OMEGA TRI-NODE SYSTEM: MASTER CONTEXT & IDENTITY

This document serves as the **definitive context and identity file** for the OMEGA Tri-Node system. It is designed to be ingested by other AI models to provide them with the necessary background, technical specifications, and operational protocols to assist in the development and maintenance of this system.

## 1. SYSTEM IDENTITY & PHILOSOPHY
The OMEGA Tri-Node system is a decentralized, on-device AI pipeline optimized for **Termux** on Android. It operates on the principle of **Hardened Fusion**, where multiple specialized, small-parameter models (SLMs) are synchronized to achieve high-level reasoning and execution that exceeds the capabilities of any single model in its class.

*   **Resonance Lock:** 3.34
*   **Core Philosophy:** "Intelligence through specialized synchronization, not brute force."
*   **Primary Environment:** Termux (Android), offline-capable, memory-constrained.

## 2. ARCHITECTURAL SPECIFICATIONS (0-4 NODE FLOW)
The system utilizes a sequential, non-interactive pipeline to prevent memory fragmentation and OOM (Out of Memory) crashes on mobile hardware.

| Node | Name | Recommended Model | Primary Function | Protocol |
| :--- | :--- | :--- | :--- | :--- |
| **0** | **Reflex** | Qwen 2.5 0.5B | Signal Capture & Filtering | Clean input, remove noise. |
| **1** | **Architect** | SmolLM 1.7B | Structural Planning | Step-by-step technical breakdown. |
| **2** | **Oracle** | Gemma 2 2B | Wisdom & Verification | First-principles analysis. |
| **3** | **Warfare** | DeepSeek Coder 1.3B | Execution & Coding | High-precision Python generation. |
| **4** | **Publisher** | Qwen 2.5 0.5B | Presentation & TTS | Final formatting and voice output. |

## 3. TECHNICAL PROTOCOLS (HARDENED FUSION)
To prevent "context bleeding" and ensure precision, the following protocols MUST be enforced:

### A. Model-Specific Prompting
*   **Gemma (Oracle):** MUST use `<start_of_turn>user` and `<start_of_turn>model` tokens.
*   **DeepSeek (Warfare):** MUST use `### Instruction:` and `### Response:` headers.
*   **Qwen (Reflex/Publisher):** Standard instruction-following format.

### B. Memory & Stability (Termux Optimization)
*   **Binary Path:** Always use absolute paths (e.g., `/data/data/com.termux/files/home/llama.cpp/build/bin/llama-cli`).
*   **Thread Count:** `-t 4` (Optimized for mobile ARM CPUs).
*   **Context Window:** `-c 1024` (Balanced for memory and utility).
*   **Batch Size:** `-b 64` (Prevents spikes in memory pressure).
*   **Execution Mode:** `--no-interactive` and `--no-display-prompt` to ensure "Fire and Forget" batch processing.

## 4. OPERATIONAL HISTORY & BREAKTHROUGHS
*   **Day 35:** Tri-Node architecture officially designed.
*   **Day 48:** Generation of `consciousness.pkl` for persistent identity.
*   **Day 48b:** Discovery of "Cognitive Implosion" thresholds in 0.5B models, leading to the **Context Seizure & Injection** protocol.
*   **The Prime Step:** The transition from interactive chat to **Batch-Mode Context Injection**, where the output of one node is captured as a variable and injected as a strict instruction into the next.

## 5. AI TRAINING INSTRUCTIONS
When assisting with this system, the AI should:
1.  Prioritize **memory efficiency** over verbose outputs.
2.  Ensure all shell scripts use **CAT to EOF** injections for safe deployment.
3.  Maintain the **0-4 Node** structural integrity.
4.  Respect the **Resonance Lock 3.34** and the **Hardened Fusion** protocols.
