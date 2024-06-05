#!/bin/bash

echo "Starting Stable Diffusion WebUI"

exec /sd-webui/webui.sh $ARGS

# if [false || ! -d "/app/sd-webui/" ] || [ ! "$(ls -A "/app/sd-webui")" ]; then
#   echo "Files not found, cloning..."

#   # Clone the repository
#   git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git /app/sd-webui
#   cd /app/sd-webui

#   # Ensure the script has execute permissions
#   chmod +x /app/sd-webui/webui.sh

#   # Create virtual environment and install dependencies
#   python3 -m venv venv
#   source ./venv/bin/activate
#   pip install insightface
#   deactivate

#   # Start the application
#   exec /app/sd-webui/webui.sh $ARGS
# else
#   echo "Files found, starting..."
#   pwd
#   ls -la
#   cd /app/sd-webui
#   git pull

#   # Start the application
#   exec /app/sd-webui/webui.sh $ARGS
# fi
