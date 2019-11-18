

void SearchForBuildingsX(int x, int xDir) {
  TILE_TYPE prev = TILE_TYPE.ROAD;
  MODE mode = MODE.SEARCH;
  for (int y = 0; y < TD; y += 1) {
    Tile t = getTile(x, y);
    Tile above = getTile(x-xDir, y);
    if (t == null) continue;

    if (above == null || above.markAs != TILE_TYPE.ROAD) continue;


    if (t.type == TILE_TYPE.BUILDING) continue;
    if (t.markAs == TILE_TYPE.GROUND) {
      if (mode == MODE.SEARCH) { //can begin
        float c = 1.0 - (float(TA - x) / float(TA));
        if (random(1) < c) {
          mode = MODE.PLACE;
        } else {
          mode = MODE.DONTPLACE;
        }
      }
    } else if (t.markAs == TILE_TYPE.ROAD) {
      if (mode == MODE.PLACE || mode == MODE.DONTPLACE) {
        mode = MODE.SEARCH;
      }
    }

    if (mode == MODE.PLACE) {
      int w = buildingSize * xDir;
      int h = buildingSize;

      while (true) {
        boolean doesItFit = true;
        for (int yy = y; yy < y + h; yy += 1) {
          for (int xx = x;; xx += xDir) {

            if (xDir > 0) {
              if (xx >= x + w) break;
            } else if (xDir < 0) {
              if (xx <= x + w) break;
            }

            Tile tt = getTile(xx, yy);
            if (tt == null || tt.markAs == TILE_TYPE.ROAD) {
              doesItFit = false;
            }
          }
          if (!doesItFit) break;
        }

        if (doesItFit) {
          for (int yy = y; yy<y+h; yy += 1) {
            for (int xx = x; ; xx += xDir) {

              if (xDir > 0) {
                if (xx >= x + w) break;
              } else if (xDir < 0) {
                if (xx <= x + w) break;
              }
              Tile tt = getTile(xx, yy);

              tt.type = TILE_TYPE.BUILDING;
            }
          }

          w += (random(1) < 0.4) ? 1*xDir : 0;
          h += (random(1) < 0.4) ? 1 : 0;


          if (abs(w) > buildingSizeMax || abs(h) > buildingSizeMax) break;
          if (random(1) < 0.1) break;
        } else {
          break;
        }
      }
      y += h-1;
    }


    prev = t.type;
  }
}
