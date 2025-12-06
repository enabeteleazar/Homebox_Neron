import React from "react";

function Tile({ title, port, status, uptime, image }) {
  return (
    <div className="tile">
      <div className="tile-header">
        <h3 className="tile-title">{title}</h3>
        <div className={`status-dot status-${status}`}></div>
      </div>
      
      <div className="tile-info">
        {port && port !== "N/A" && (
          <div className="tile-detail">
            <span className="detail-label">Port:</span>
            <span className="detail-value">{port}</span>
          </div>
        )}
        
        {uptime && (
          <div className="tile-detail">
            <span className="detail-label">Uptime:</span>
            <span className="detail-value">{uptime}</span>
          </div>
        )}
        
        {image && (
          <div className="tile-detail tile-image">
            <span className="detail-label">Image:</span>
            <span className="detail-value">{image}</span>
          </div>
        )}
      </div>
      
      <div className="tile-status-text">
        {status === "up" && "🟢 En ligne"}
        {status === "down" && "🔴 Arrêté"}
        {status === "warning" && "🟡 Pause"}
      </div>
    </div>
  );
}

export default Tile;
