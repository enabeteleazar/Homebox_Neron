from fastapi import FastAPI
import os

app = FastAPI(title="Néron-Core API")

@app.get("/")
def read_root():
    return {"message": "Néron-Core est en ligne !"}

# Exemple de route pour vérifier la communication avec Ollama ou Telegram
@app.get("/status")
def status():
    return {
        "neron-core": "OK",
        "telegram": "en attente",
        "ollama": "en attente"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("NERON_CORE_PORT", 4000)))

