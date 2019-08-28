void makeRoads() {  

  //roads down
  for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {
    for (int y = 0; y < MAP_HEIGHT; y += BLOCK_HEIGHT) {
      if (xChance(x)) {
        for (int yy = y; yy < y + BLOCK_HEIGHT && yy < MAP_HEIGHT; yy += 1) {
          for (int xx = x; xx < x + ROAD_WIDTH && xx < MAP_WIDTH; xx += 1) {
            typeMap[xx][yy] = TYPES.ROAD; 
            if (xChance2(xx)) {
              displayMap[xx][yy] = TYPES.ROAD;
            }
          }
        }
      }
    }
  }

  //roads across
  for (int y = 0; y < MAP_HEIGHT; y += BLOCK_HEIGHT) {
    for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {

      if (xChance(x)) {
        for (int xx = x; xx < x + BLOCK_HEIGHT && xx < MAP_WIDTH; xx += 1) {
          for (int yy = y; yy < y + ROAD_WIDTH && yy < MAP_HEIGHT; yy += 1) {
            typeMap[xx][yy] = TYPES.ROAD; 
            if (xChance2(xx)) {
              displayMap[xx][yy] = TYPES.ROAD;
            }
          }
        }
      }
    }
  }
}
