import React from "react";
import "../App.css";

export default function Tile({ title, port, status }) {
  
  const statusClass = {
    up: "status-up",
    down: "status-down",
    warning: "status-warning",
    default: "status-warning"
  }[status || "default"];

  return (
    <div className="tile">
      <div className="tile-title">{title}</div>

      {port && (
        <div className="tile-info">
          Port : <strong>{port}</strong>
        </div>
      )}

      <div className={`status-dot ${statusClass}`}></div>
    </div>
  );
}

