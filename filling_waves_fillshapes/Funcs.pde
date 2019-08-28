boolean OOB(int x, int y) {
  return (x < 0 || x > TA - 1 || y < 0 || y > TD-1);
}

Node getNodeFromScreen(int x, int y) {
  int xx = x / TILE_SIZE;
  int yy = y / TILE_SIZE;
  
  return getNode(xx,yy);
}


int IX(int x, int y) {
  return y * TA + x;
}

Node getNode(int x, int y){
  if (!OOB(x,y)) {
    return nodes[x][y];
  } else {
    return null;
  }
}
