#!/bin/bash
# Script de démarrage de la stack Néron
# Chemin : /homebox/services/neron/start.sh

ROOT="/homebox"
ENV_FILE="$ROOT/.env"
NERON_DIR="$ROOT/services/neron"

echo "======================================"
echo "        🚀 Démarrage de NÉRON"
echo "======================================"

start_stack() {
    NAME=$1
    COMPOSE_PATH=$2

    echo ""
    echo "➡️  Lancement de $NAME ..."
    docker compose --env-file "$ENV_FILE" -f "$COMPOSE_PATH" up -d --build

    if [ $? -ne 0 ]; then
        echo "❌ Erreur lors du démarrage de $NAME"
        exit 1
    fi

    echo "✅ $NAME démarré"
    sleep 2  # Petite pause pour stabilisation
}

# ORDRE LOGIQUE CORRIGÉ
echo "📦 Démarrage de la couche infrastructure..."

# 1. Ollama d'abord (moteur LLM)
start_stack "ollama" "$NERON_DIR/ollama/docker-compose.yaml"

echo ""
echo "🧠 Démarrage de la couche intelligence..."

# 2. neron-core (API centrale)
start_stack "neron-core" "$NERON_DIR/neron-core/docker-compose.yaml"

echo ""
echo "💬 Démarrage de l'interface utilisateur..."

# 3. neron-telegram (interface)
start_stack "neron-telegram" "$NERON_DIR/neron-telegram/docker-compose.yaml"

echo ""
echo "⚙️  Démarrage des automatisations..."

# 4. Services d'automatisation (parallèle possible)
start_stack "node-red" "$NERON_DIR/node-red/docker-compose.yaml"
start_stack "n8n" "$NERON_DIR/n8n/docker-compose.yaml"

echo ""
echo "======================================"
echo "  ✅ Stack Néron opérationnelle"
echo "======================================"
echo ""
echo "📊 État des services :"
docker ps --filter "network=homebox" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "🔍 Vérification de l'API neron-core..."
sleep 3
curl -s http://localhost:4000/ | jq '.' || echo "⚠️  API non accessible"
