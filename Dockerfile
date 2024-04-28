FROM ollama/ollama:0.1.32

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    gnupg

# Download and install NVIDIA repository key
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

# Add NVIDIA repository to apt sources list
RUN curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt-get update && \
    apt-get install -y nvidia-container-toolkit

# Configure NVIDIA runtime for Docker
RUN nvidia-ctk runtime configure --runtime=docker

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*