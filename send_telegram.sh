#!/bin/bash

# --- Fichier des variables ---
ENV_FILE="/home/eleazar/Homebox_Neron/.env.global"

# --- Chargement sécurisé du .env ---
if [ -f "$ENV_FILE" ]; then
    while IFS='=' read -r key value; do
        # ignorer les lignes vides ou commentaires
        [[ -z "$key" || "$key" =~ ^# ]] && continue
        export "$key"="$value"
    done < "$ENV_FILE"
else
    echo "Erreur : fichier $ENV_FILE introuvable"
    exit 1
fi

# --- Vérification du paramètre ---
if [ -z "$1" ]; then
    echo "Usage: send_telegram.sh \"Votre message\""
    exit 1
fi

MESSAGE="$1"

# --- Envoi Telegram ---
curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${TELEGRAM_CHAT_ID}" \
    -d "text=${MESSAGE}" \
    > /dev/null

echo "Message envoyé à Telegram ✅"

