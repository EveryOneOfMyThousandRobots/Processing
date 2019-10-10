void setNeighbours() {
  for (int x = 0; x < T_ACROSS; x += 1) {
    for (int y = 0; y < T_DOWN; y += 1) {
      
      grid[x][y].setNeighbours();
    }
  }
}

Tile getTile(int x, int y) {
  if (!iOOB(x, y)) {
    return grid[x][y];
  } else {
    return null;
  }
}


boolean iOOB(int x, int y) {
  return (x < 0 || x > T_ACROSS-1 || y < 0 || y > T_DOWN - 1);
}
