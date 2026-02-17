# OMEGA Tri-Node Pipeline (0-4 Node Architecture)

An optimized, multi-node AI pipeline designed specifically for **Termux** on Android. This system leverages the power of multiple specialized LLMs to provide a robust reasoning and execution workflow.

## 🚀 Architecture

The pipeline follows a **0-4 Node** flow, ensuring each stage of the process is handled by the most efficient model for that task:

| Node | Name | Model (Recommended) | Function |
| :--- | :--- | :--- | :--- |
| **0** | **Reflex** | Qwen 2.5 0.5B | Signal capture, query refinement, and filtering. |
| **1** | **Architect** | SmolLM 1.7B | Structural planning and step-by-step breakdown. |
| **2** | **Oracle** | Gemma 2 2B | First-principles analysis and strategy verification. |
| **3** | **Warfare** | DeepSeek Coder 1.3B | High-precision code generation and execution. |
| **4** | **Publisher** | Qwen 2.5 0.5B | Final presentation, formatting, and optional TTS. |

## 🛠️ Key Features

*   **Hardened Fusion:** Prevents "context bleeding" by using model-specific prompt formats (e.g., Gemma's `<start_of_turn>` and DeepSeek's `### Instruction:`).
*   **Termux Optimized:** Uses absolute binary paths and memory-safe parameters (`-t 4`, `-c 1024`, `-b 64`) to prevent OOM crashes.
*   **Fire & Forget:** Implements `--no-interactive` and `--no-display-prompt` for clean, automated batch execution.
*   **TTS Integration:** Automatically speaks the final output if `termux-tts-speak` is available.

## 📦 Installation

1.  Ensure you have `llama.cpp` compiled in your Termux environment.
2.  Clone this repository:
    ```bash
    git clone https://github.com/bekingdomcomejoker-cpu/omega-tri-node.git
    cd omega-tri-node
    chmod +x tri_node_omega.sh
    ```
3.  Verify your model paths in `tri_node_omega.sh`.
4.  Run the pipeline:
    ```bash
    ./tri_node_omega.sh
    ```

## 📜 License

Private / Personal Use.
