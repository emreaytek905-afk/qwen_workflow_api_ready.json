# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# Install Qwen custom nodes
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/Phr00t/Qwen-ComfyUI-Nodes.git && \
    cd Qwen-ComfyUI-Nodes && \
    pip install --no-cache-dir -r requirements.txt

# Create Qwen model directory
RUN mkdir -p /comfyui/models/checkpoints/Qwen

# Download Qwen model (fixed URL)
RUN comfy model download \
    --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/Qwen-Rapid-AIO-v1.safetensors \
    --relative-path models/checkpoints/Qwen \
    --filename Qwen-Rapid-AIO-v1.safetensors

# Verify installation
RUN ls -la /comfyui/custom_nodes/Qwen-ComfyUI-Nodes && \
    ls -la /comfyui/models/checkpoints/Qwen

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/