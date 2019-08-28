void makeBuildings_EAST_WEST(int dir) {
  int start = 0;
  if (dir == 1) {
    start = BLOCK_WIDTH + ROAD_WIDTH;
  } else if (dir == -1) {
    start = BLOCK_WIDTH-1;
  } else {
    return;
  }
  for (int x = start; x < MAP_WIDTH; x += BLOCK_WIDTH) {


    for (int y = 0; y < MAP_HEIGHT; y += 1) {
      if (random(1) < 0.1) {
        y += floor(random(1, 3));
        continue;
      } else if (random(1) <= 0.01) {
        y += BUILDING_MAX;
        continue;
      } else if (!xChance(x)) {
        y += floor(random(BUILDING_MAX));
        continue;
      }



      TYPES t = getType(x-dir, y);

      if (t != null && t == TYPES.ROAD) { 

        int b_height = BUILDING_MIN;
        int b_width = BUILDING_MIN;
        while (true) {
          int tlx = dir == 1 ? x : x - b_width;
          int tly = y;
          int brx = dir == 1 ? x + b_width : x;
          int bry = y + b_height;

          boolean fits = BuildingFits(tlx, tly, brx, bry);

          if (!fits) {
            b_width -= 1;
            b_height -= 1;
            break;
          } else {
            if (b_width >= BUILDING_MAX || b_height >= BUILDING_MAX || random(1) < 0.02) break;

            if (random(1) < 0.4) {
              b_width += 1;
            }

            if (random(1) < 0.4) {
              b_height += 1;
            }
          }
        }
        if (b_width >= BUILDING_MIN && b_height >= BUILDING_MIN) {
          int tlx = dir == 1 ? x : x - b_width;
          int tly = y;
          int brx = dir == 1 ? x + b_width : x;
          int bry = y + b_height;

          buildings.add(new Building(tlx, tly, b_width,b_height,dir == 1 ? FACING.WEST : FACING.EAST));
          for (int xx = tlx; xx <= brx; xx += 1) {
            for (int yy = tly; yy <= bry; yy += 1) {
              TYPES tt = getType(xx, yy);
              if (tt == null) {
                if (xx == tlx || xx == brx || yy == tly || yy == bry) {
                  typeMap[xx][yy] = TYPES.WALL;
                  displayMap[xx][yy] = TYPES.WALL;
                } else {
                  typeMap[xx][yy] = TYPES.INTERIOR;
                  displayMap[xx][yy] = TYPES.INTERIOR;
                }
              }
            }
          }
        }

        y += b_height-1;
      }
    }
  }
}
