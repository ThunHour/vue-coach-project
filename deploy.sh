#!/bin/bash
set x
docker compose down

docker system prune -af

docker compose up -d