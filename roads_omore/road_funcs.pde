void verticalRoads() {
  for (int x = 0; x < MA; x += 1) {

    if (x % BLOCK_SIZE == 0) {

      boolean go = false;

      for (int y = 0; y < MD; y += 1) {
        if (y % BLOCK_SIZE == 0) {
          if (random(1) < 0.5) {
            go = true;
          }
        }

        if (go) {
          map[x][y] = TYPE.ROAD;
        }

        if (y % BLOCK_SIZE == BLOCK_SIZE -1) {
          go = false;
        }
      }
    }
  }
}


void horizRoads() {
  for (int y = 0; y < MA; y += 1) {

    if (y % BLOCK_SIZE == 0) {

      boolean go = false;

      for (int x = 0; x < MD; x += 1) {
        if (x % BLOCK_SIZE == 0) {
          if (random(1) < 0.5) {
            go = true;
          }
        }

        if (go) {
          map[x][y] = TYPE.ROAD;
        }

        if (x % BLOCK_SIZE == BLOCK_SIZE -1) {
          go = false;
        }
      }
    }
  }
}
