import React from "react";
import "../App.css";

export default function ServerTile({ cpu, ram, temp, status }) {
  
  const statusClass = {
    up: "status-up",
    down: "status-down",
    warning: "status-warning",
    default: "status-warning"
  }[status || "default"];

  return (
    <div className="server-tile">
      <div className="server-header">
        <h2>Serveur HomeBox</h2>
        <div className={`status-dot ${statusClass}`}></div>
      </div>

      <div className="server-metrics">
        <div className="metric">
          <span className="metric-label">CPU</span>
          <span className="metric-value">{cpu}%</span>
        </div>

        <div className="metric">
          <span className="metric-label">RAM</span>
          <span className="metric-value">{ram}%</span>
        </div>

        <div className="metric">
          <span className="metric-label">Température</span>
          <span className="metric-value">{temp}°C</span>
        </div>
      </div>
    </div>
  );
}

