Tile getTileAtMouse() {
  int x = floor((float)mouseX / (float)TS);
  int y = floor((float)mouseY / (float)TS);

  if (OOB(x, y)) {
    return null;
  } else {
    return tiles[x][y];
  }
}


boolean OOB(int x, int y) {
  return x < 0 || x > TA -1 || y < 0 || y > TD - 1;
}

void clearSelected() {
  for (int y = 0; y < TD; y += 1) {
    for (int x = 0; x < TA; x += 1) {
      tiles[x][y].selected = false;
    }
  }
}
