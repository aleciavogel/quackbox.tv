#!/bin/bash

# Get dependencies ready
mix deps.get
mix deps.compile

# Compile assets
cd assets && npm install && npm run build && cd ../ && mix phx.digest

# Set-up server
mix ecto.create
mix ecto.migrate

# Start server
mix phx.server