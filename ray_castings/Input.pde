void mouseReleased() {
  if (mouseButton == LEFT) {
    Tile t = getTileCoords(mouseX,mouseY);
    
    if (t != null) {
      t.toggle();
    }
    setNeighbours();
    setSurfaces();
  }
}
