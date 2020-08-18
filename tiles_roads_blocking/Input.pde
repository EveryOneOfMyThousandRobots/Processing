void keyPressed() {
  char c = Character.toUpperCase(key);
  TILE_TYPE type = null;

  if (c == 'R') {
    type = TILE_TYPE.ROAD;
  }
  if (c == 'G') {
    type = TILE_TYPE.GRASS;
  }

  if (c == 'E') {
    type = TILE_TYPE.EMPTY;
  }
  if (type != null) {
    for (int y = 0; y < TD; y += 1) {
      for (int x = 0; x < TA; x += 1) {
        Tile t = tiles[x][y];
        if (t.selected) {
          t.type = type;
        }
      }
    }
    clearSelected();
   
  }
  
}
