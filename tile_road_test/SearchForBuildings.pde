enum MODE {
  SEARCH, PLACE, DONTPLACE;
}

void SearchForBuildings(int y, int yDir) {
  TILE_TYPE prev = TILE_TYPE.ROAD;
  MODE mode = MODE.SEARCH;
  for (int x = 0; x < TA; x += 1) {
    Tile t = getTile(x, y);
    Tile above = getTile(x,y-yDir);
    if (t == null) continue;
    
    if (above == null || above.markAs != TILE_TYPE.ROAD) continue;
    
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
      int w = buildingSize;
      int h = buildingSize * yDir;

      while (true) {
        boolean doesItFit = true;
        for (int xx = x; xx < x + w; xx += 1) {
          for (int yy = y; ; yy += yDir) {
            if (yDir > 0) {
              if (yy >= y + h) break;
            } else if (yDir < 0) {
              if (yy <= y + h) break;
            }

            Tile tt = getTile(xx, yy);
            if (tt == null || tt.markAs == TILE_TYPE.ROAD) {
              doesItFit = false;
            }
          }
          if (!doesItFit) break;
        }

        if (doesItFit) {
          for (int xx = x; xx < x + w; xx += 1) {
            for (int yy = y; ; yy += yDir) {
            if (yDir > 0) {
              if (yy >= y + h) break;
            } else if (yDir < 0) {
              if (yy <= y + h) break;
            }
              Tile tt = getTile(xx, yy);
              
              tt.type = TILE_TYPE.BUILDING;
            }
            
            
          }
          
          w += (random(1) < 0.4) ? 1 : 0;
          h += (random(1) < 0.4) ? 1*yDir : 0;
          
          
          if (w > buildingSizeMax || abs(h) > buildingSizeMax) break;
          if (random(1) < 0.1) break;
        } else {
          break;
        }
      }
      x += w-1;
    }


    prev = t.type;
  }
}
