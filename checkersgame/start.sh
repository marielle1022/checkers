#!/bin/bash

export MIX_ENV=prod
#DONE: changed port from 4791 to 4569
export PORT=4569

echo "Starting app..."

# Start to run in background from shell.
#_build/prod/rel/checkers/bin/checkers/checkersgame start

# Foreground for testing and for systemd
_build/prod/rel/checkers/bin/checkers/checkersgame start

# TODO: Add a systemd service file
#       to start your app on system boot.
