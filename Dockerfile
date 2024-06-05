FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

WORKDIR /app

# Update and install packages
USER root
RUN apt-get update && \
    apt-get install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Create a non-root user
RUN useradd -m webui

# Ensure 'webui' user has ownership of /app directory
RUN chown -R webui:webui /app

# Switch to 'webui' user
USER webui

# Create the sd-webui directory
RUN mkdir /app/sd-webui

# Clone the repository and perform subsequent actions
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git /app/sd-webui && \
    cd /app/sd-webui && \
    chmod +x /app/sd-webui/webui.sh && \
    python3 -m venv venv && \
    source ./venv/bin/activate && \
    pip install insightface && \
    deactivate

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]
