FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/Yummiii/sd-webui-forge-docker

WORKDIR /app

RUN apt update && apt upgrade -y \
    && apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip

COPY run.sh /app/run.sh

# Ensure the script is executable
RUN chmod +x /app/run.sh

# Create the directory with correct permissions
RUN mkdir -p /app/sd-webui && chown root:root /app/sd-webui

# Copy the data directory from the build context to the image
COPY data /app/sd-webui

ENTRYPOINT ["/app/run.sh"]
