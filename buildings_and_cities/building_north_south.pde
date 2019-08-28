void makeBuildings_NORTH_SOUTH(int dir) {
  int start = 0;
  if (dir == 1) {
    start = BLOCK_WIDTH + ROAD_WIDTH;
  } else if (dir == -1) {
    start = BLOCK_WIDTH-1;
  } else {
    return;
  }
  for (int yp = start; yp < MAP_HEIGHT; yp += BLOCK_WIDTH) {


    for (int xp = 0; xp < MAP_WIDTH; xp += 1) {
      if (random(1) < 0.1) {
        xp += floor(random(1, 3));
        continue;
      } else if (random(1) <= 0.01) {
        xp += BUILDING_MAX;
        continue;
      } else if (!xChance2(xp)) {
        xp += floor(random(1, BUILDING_MAX));
      }



      TYPES t = getType(xp, yp-dir);

      if (t != null && t == TYPES.ROAD) { 

        int b_height = BUILDING_MIN;
        int b_width = BUILDING_MIN;
        while (true) {
          int tlx = xp;
          int tly = dir == 1 ? yp : yp - b_height; 
          int brx = xp + b_width;
          int bry = dir == 1 ? yp + b_height : yp;

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
          int tlx = xp;
          int tly = dir == 1 ? yp : yp - b_height; 
          int brx = xp + b_width;
          int bry = dir == 1 ? yp + b_height : yp;

          buildings.add(new Building(tlx, tly, b_width,b_height,dir == 1 ? FACING.NORTH : FACING.SOUTH));
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

        xp += b_width;
      }
    }
  }
}
