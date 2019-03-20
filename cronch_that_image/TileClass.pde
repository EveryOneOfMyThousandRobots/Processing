float tileOpacity = 125;
final float sampleFactor = 0.1;

class Tile {
  PVector[] offset = new PVector[4];
  PVector pos, dims;
  //ArrayList<Tile> children = new ArrayList<Tile>();
  boolean children;
  double stdi = 0;
  CHANNEL channel;
  color c;
  float diff;
  float opac;
  SImage img;


  //boolean sameSize(Tile o) {
  //  return sameSize(floor(o.dims.x), floor(o.dims.y));
  //}
  //boolean sameSize(int w, int h) {
  //  if (children) return false;
  //  if (floor(dims.x) == w && floor(dims.y) == h) {
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}
  Tile(SImage img, float x, float y, float w, float h) {
    this.img = img;
    float w10 = w/10.0;
    float h10 = h/10.0;
    offset[0] = new PVector(random(-w10, w10), random(-h10, h10));
    offset[1] = new PVector(random(-w10, w10), random(-h10, h10));
    offset[2] = new PVector(random(-w10, w10), random(-h10, h10));
    offset[3] = new PVector(random(-w10, w10), random(-h10, h10));
    pos = new PVector(floor(x), floor(y));
    dims = new PVector(floor(w), floor(h));
    this.channel = img.channel;
    c = getAverage(img.img, x, y, w, h);
    stdi = getRandomStdi(img.img, x, y, w, h, this.channel);
    diff = abs((float)(stdi - img.STDIV));
    opac = 255;//tileOpacity * (1.0 + (1.0 / diff));
    if (stdi > img.STDIV_SQRT) {
      float w2 = ceil(w/2.0);
      float h2 = ceil(h/2.0);
      if (w2 >= img.tileMinWidth && h2 >= img.tileMinHeight) {
        children = true;
        img.tiles.add(new Tile(img, x, y, w2, h2));
        img.tiles.add(new Tile(img, x+w2, y, w2, h2));
        img.tiles.add(new Tile(img, x, y+h2, w2, h2));
        img.tiles.add(new Tile(img, x+w2, y+h2, w2, h2));
      }
    }
  }

  void draw(Tile o) {

    //stroke(0);
    img.grp.noStroke();
    img.grp.fill(lerpColor(c, o.c, 0.5), opac);
    img.grp.rect(o.pos.x, o.pos.y, o.dims.x, o.dims.y);
  }

  void drawOffset() {

    //stroke(0);
    img.grp.noStroke();
    img.grp.fill(c, 8);
    for (PVector o : offset) {
      img.grp.rect(pos.x+ o.x, pos.y + o.y, dims.x, dims.y);
    }
  }
}
