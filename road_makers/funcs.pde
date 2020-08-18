Node getNode(int x, int y) {
  if (!OOB(x, y)) {
    return nodes[x][y];
  }
  return null;
}

boolean OOB(int x, int y) {
  return (x < 0 || x > TA -1 || y < 0 || y > TD - 1);
}

Node getRandom() {
  int x = floor(random(TA));
  int y = floor(random(TD));

  return nodes[x][y];
}

Node getRandomNodeFromColumn(int x) {
  int y = floor(random(TD));

  return nodes[x][y];
}

Node getRandomNodeFromRow(int y) {
  int x = floor(random(TA));

  return nodes[x][y];
}
