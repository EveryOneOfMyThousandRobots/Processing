Tile getTile(int x, int y) {
  if (!valid(x,y)) {
    return null;
  }
  
  return tiles[x][y];
}

boolean valid(int x, int y) {
  if (x < 0 || x > tiles.length-1 || y < 0 || y > tiles[0].length-1) {
    return false;
  }
  
  return true;
}
