FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

WORKDIR /app

# Run system updates and install dependencies as root
RUN apt update && apt upgrade -y
RUN apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip sudo

# Create a non-root user and set permissions
RUN useradd -m webui && echo 'webui ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN mkdir -p /app/sd-webui && chown -R webui:webui /app

# Copy the run script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh && chown webui:webui /app/run.sh

# Switch to the non-root user
USER webui

# Run the main script
ENTRYPOINT ["/app/run.sh"]
