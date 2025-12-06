import React from "react";
import Tile from "./components/Tile";
import ServerTile from "./components/ServerTile";
import "./App.css";

function App() {
  return (
    <div className="dashboard-container">
      <h1 className="dashboard-title">Dashboard HomeBox</h1>

      <div className="dashboard-grid">

        {/* Grande tuile serveur */}
        <ServerTile cpu={23} ram={48} temp={36} status="up" />

        {/* Tuiles services */}
        <Tile title="Home Assistant" port="8123" status="up" />
        <Tile title="Codi-TV" port="8088" status="down" />
        <Tile title="Ollama" port="11434" status="up" />
        <Tile title="Grafana" port="3000" status="warning" />
        <Tile title="Prometheus" port="9090" status="up" />
      </div>
    </div>
  );
}

export default App;

