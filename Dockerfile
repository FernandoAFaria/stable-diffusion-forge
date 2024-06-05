FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

WORKDIR /app

# Install required packages
RUN apt update && apt upgrade -y && \
    apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip

# Add the script and set permissions
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Create a non-privileged user
RUN useradd -m webui

# Create the sd-webui directory with proper permissions
RUN mkdir /app/sd-webui && chown -R webui:webui /app

# Switch to non-privileged user
USER webui

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]
