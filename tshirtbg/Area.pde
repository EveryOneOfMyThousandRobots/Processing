class Area {
  PVector pos, dims;
  float chanceLeft, chanceRight;
  color colourA, colourB;
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  Fade fade;
  Area(float x, float y, float w, float h, Fade fade) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    chanceLeft = 0;
    chanceRight = 0;
    this.fade = fade;
  }

  color getColour(float x, float y) {
    color cc = color(0);
    float N = 0;
    switch (fade) {
    case NONE:
      cc = colourA;
      break;
    case TB:
       N = y / dims.y;
      cc = lerpColor(colourA, colourB, gs(N));
      
      break;
    case LR:
      N = x / dims.x;
      cc = lerpColor(colourA, colourB, gs(N));    
      break;
    case TLBR:
      N = (x + y) / (dims.x + dims.y);
      cc = lerpColor(colourA, colourB, gs(N));
      break;
    case TRBL:
      N = ((dims.x - x) + y) / (dims.x + dims.y);
      cc = lerpColor(colourA, colourB, gs(N));
      break;
      
    }


    return cc;
  }



  void render() {
    for (float x = 0; x < dims.x; x += TILE_SIZE) {
      float chance = getSigmoid(map(lerp(chanceLeft, chanceRight, x / dims.x), 0, 1, -6, 6));
      for (float y = 0; y < dims.y; y += TILE_SIZE) {
        //float cc = (x + y) / (dims.x + dims.y);
        color c = color(0);

        noStroke();
        if (random(1) < chance) {
          c = color(0); //lerpColor(topLeft, bottomRight, gs(random(1)));
        } else {
          c = getColour(x,y);
        }
        tiles.add(new Tile(this, x, y, c));
      }
    }
  }

  void draw() {
    for (Tile t : tiles) {
      t.draw();
    }
  }
}
