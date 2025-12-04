
#!/bin/bash

ENV_FILE="/home/eleazar/homebox/.env"

# Charge le fichier .env s'il existe
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "Erreur : fichier .env introuvable !"
    exit 1
fi

# Vérification des variables Telegram
if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$TELEGRAM_CHAT_ID" ]; then
    echo "Erreur : BOT_TOKEN ou CHAT_ID manquant dans le .env"
    exit 1
fi

# Vérifie qu'on est bien dans un dépôt Git
if [ ! -d ".git" ]; then
    echo "Erreur : ce dossier n'est pas un dépôt Git."
    exit 1
fi

# Demande le message du commit
read -p "Entrez le message du commit : " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    echo "Erreur : message de commit vide."
    exit 1
fi

# Ajout des fichiers
git add .

# Commit
git commit -m "$COMMIT_MSG"

# Push
git push -u origin main
if [ $? -ne 0 ]; then
    echo "Erreur : push échoué."
    exit 1
fi
git push -u origin main

# Envoi notification Telegram
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="🚀 *HomeBox* — Commit poussé avec succès :\n\n💬 $COMMIT_MSG" \
    -d parse_mode="Markdown" >/dev/null

echo "✅ Commit + push + notification Telegram envoyés !"
