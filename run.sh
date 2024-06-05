#!/bin/bash

echo "Starting Stable Diffusion WebUI"

if [false || ! -d "/sd-webui/" ] || [ ! "$(ls -A "/sd-webui")" ]; then
  echo "Files not found, cloning..."

  # Clone the repository
  git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git /sd-webui
  cd /sd-webui

  # Ensure the script has execute permissions
  chmod +x /sd-webui/webui.sh

  # Create virtual environment and install dependencies
  python3 -m venv venv
  source ./venv/bin/activate
  pip install insightface
  deactivate

  # Start the application
  exec /sd-webui/webui.sh $ARGS
else
  echo "Files found, starting..."
  pwd
  ls -la
  cd /sd-webui
  git pull

  # Start the application
  exec /sd-webui/webui.sh $ARGS
fi
