# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# Install Qwen custom nodes (using lrzjason's Comfyui-QwenEditUtils - the working repo)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/lrzjason/Comfyui-QwenEditUtils.git && \
    cd Comfyui-QwenEditUtils && \
    pip install --no-cache-dir -r requirements.txt || true

# Create Qwen model directory
RUN mkdir -p /comfyui/models/checkpoints/Qwen

# Download Qwen model (fixed URL with resolve instead of blob)
RUN comfy model download \
    --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/Qwen-Rapid-AIO-v1.safetensors \
    --relative-path models/checkpoints/Qwen \
    --filename Qwen-Rapid-AIO-v1.safetensors

# Verify installation
RUN ls -la /comfyui/custom_nodes/Comfyui-QwenEditUtils && \
    ls -la /comfyui/models/checkpoints/Qwen

# Set working directory
WORKDIR /comfyui

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
