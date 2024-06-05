FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

WORKDIR /app

# Update and install packages as root
USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the run script and set permissions
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Create a non-root user
RUN useradd -m webui && \
    chown -R webui:webui /app

# Switch to the non-root user
USER webui

# Create the sd-webui directory
RUN mkdir /app/sd-webui

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]
