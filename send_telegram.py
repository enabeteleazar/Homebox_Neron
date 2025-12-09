#!/usr/bin/env python3
import os
import sys
import asyncio
from dotenv import load_dotenv
from telegram import Bot

# Vérifier que le message est fourni
if len(sys.argv) < 2:
    print("Usage: python send_telegram.py \"Votre message\"")
    sys.exit(1)

message = sys.argv[1]

# Charger les variables depuis .env.global
env_path = "/home/eleazar/Homebox_Neron/.env.global"
if not os.path.exists(env_path):
    print(f"Erreur : {env_path} introuvable")
    sys.exit(1)

load_dotenv(env_path)

# Récupérer token et chat ID
TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")

if not TOKEN or not CHAT_ID:
    print("Erreur : TELEGRAM_BOT_TOKEN ou TELEGRAM_CHAT_ID manquant dans .env.global")
    sys.exit(1)

bot = Bot(token=TOKEN)

# Fonction async d'envoi
async def send_message():
    await bot.send_message(chat_id=CHAT_ID, text=message)

# Exécuter l'asyncio
asyncio.run(send_message())

print("Message envoyé ✅")
