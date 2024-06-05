FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

# Set working directory
WORKDIR /app

# Install dependencies as root
RUN apt update && apt upgrade -y && \
    apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip

# Create a non-root user
RUN useradd -m webui

# Switch to the non-root user
USER webui

# Set working directory for the user
WORKDIR /app

# Clone the repository and set up the environment as webui user
RUN if [ ! -d "/app/sd-webui" ] || [ ! "$(ls -A /app/sd-webui)" ]; then \
      echo "Files not found, cloning..."; \
      git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git /app/sd-webui && \
      chmod +x /app/sd-webui/webui.sh && \
      cd /app/sd-webui && \
      python3 -m venv venv && \
      . ./venv/bin/activate && \
      pip install insightface && \
      deactivate; \
    else \
      echo "Files found, starting..."; \
      cd /app/sd-webui && \
      git pull; \
    fi

# Switch back to root to run the final script
USER root

# Set the entrypoint to the final script
ENTRYPOINT ["/app/sd-webui/webui.sh"]
