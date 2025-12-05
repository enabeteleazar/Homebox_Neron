#!/bin/bash

# Script pour lancer tous les services Nerón dans le bon ordre

echo "Lancement des services Nerón..."

# Nerón-core (hub central)
echo "Démarrage de neron-core..."
docker-compose --env-file /home/eleazar/homebox/.env -f neron-core/docker-compose.yaml up -d --build

# Ollama (IA)
echo "Démarrage d'Ollama..."
docker-compose --env-file /home/eleazar/homebox/.env -f ollama/docker-compose.yaml up -d --build

# Nerón-Telegram (interface bot)
echo "Démarrage de neron-telegram..."
docker-compose --env-file /home/eleazar/homebox/.env -f neron-telegram/docker-compose.yaml up -d --build

# Node-RED (automatisation locale)
echo "Démarrage de Node-RED..."
docker-compose --env-file /home/eleazar/homebox/.env -f node-red/docker-compose.yaml up -d --build

# N8N (orchestration workflows)
echo "Démarrage de N8N..."
docker-compose --env-file /home/eleazar/homebox/.env -f n8n/docker-compose.yaml up -d --build

echo "Tous les services Nerón sont démarrés !"
