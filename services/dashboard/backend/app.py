from fastapi import FastAPI
import psutil
import docker

app = FastAPI()

# --- Docker client ---
client = docker.DockerClient(base_url='unix://var/run/docker.sock')

# --- Endpoint system info ---
@app.get("/api/system")
def system_status():
    return {
        "cpu_percent": psutil.cpu_percent(interval=1),
        "ram_percent": psutil.virtual_memory().percent,
        "disk_percent": psutil.disk_usage("/").percent
    }

# --- Endpoint docker containers ---
@app.get("/api/docker")
def docker_containers():
    try:
        containers = client.containers.list(all=True)
        result = []
        for c in containers:
            result.append({
                "name": c.name,
                "status": c.status,
                "uptime": c.attrs['State']['StartedAt']
            })
        return result
    except Exception as e:
        return {"error": str(e)}

# --- Example services endpoint ---
@app.get("/api/services")
def services_list():
    # Exemple statique, à remplacer plus tard par une vraie récupération
    return [
        {"name": "Home Assistant", "status": "running", "port": 8123},
        {"name": "Prometheus", "status": "running", "port": 9090},
        {"name": "Grafana", "status": "stopped", "port": 3000},
        {"name": "Ollama", "status": "running", "port": 11400}
    ]
