HashMap<TILE_TYPE, TileType> tileTypes = new HashMap<TILE_TYPE, TileType>();
void makeTileTypes() {
  tileTypes.put(TILE_TYPE.BUILDING, new TileType(TILE_TYPE.BUILDING));
  tileTypes.put(TILE_TYPE.STRAIGHT, new TileType(TILE_TYPE.STRAIGHT));
  tileTypes.put(TILE_TYPE.TURN, new TileType(TILE_TYPE.TURN));
  tileTypes.put(TILE_TYPE.FOUR_WAY, new TileType(TILE_TYPE.FOUR_WAY));
  tileTypes.put(TILE_TYPE.THREE_WAY, new TileType(TILE_TYPE.THREE_WAY));
  tileTypes.put(TILE_TYPE.END, new TileType(TILE_TYPE.END));
}

TILE_TYPE getRandomTileType() {
  final int r = floor(random(6));

  switch (r) {
  case 0: 
    return TILE_TYPE.BUILDING;
  case 1: 
    return TILE_TYPE.STRAIGHT;
  case 2: 
    return TILE_TYPE.TURN;
  case 3: 
    return TILE_TYPE.FOUR_WAY;
  case 4: 
    return TILE_TYPE.THREE_WAY;
  case 5: 
    return TILE_TYPE.END;
  default: 
    return TILE_TYPE.BUILDING;
  }
}
static int TILE_TYPE_ID = 0;
enum TILE_TYPE {
  BUILDING(0), STRAIGHT(1), TURN(2), FOUR_WAY(3), THREE_WAY(4), END(5);
  final int id;
  private TILE_TYPE(int id) {
    this.id = id;
  }
}

class TileType {

  PVector dims;
  PGraphics img;
  TILE_TYPE type;




  TileType( TILE_TYPE type) {

    dims = new PVector(TILE_SIZE, TILE_SIZE);
    img = createGraphics(floor(TILE_SIZE), floor(TILE_SIZE));
    this.type = type;
    generate();
  }



  void generate() {

    float x0 = 0;
    float x25 = dims.x / 4;
    float x75 = dims.x * 0.75;
    float x100 = dims.x;

    float y0 = 0;
    float y25 = dims.y / 4;
    float y75 = dims.y * 0.75;
    float y100 = dims.y;
    img.beginDraw();

    img.background(51);
    switch (type) {
    case BUILDING:
      img.background(0);
      break;
    case STRAIGHT:
      img.beginShape();
      img.vertex(x25, y0);
      img.vertex(x25, y100);
      img.vertex(x75, y100);
      img.vertex(x75, y0);
      img.endShape(CLOSE);
      break;
    case TURN:
      img.beginShape();
      img.vertex(x0, y25);
      img.vertex(x0, y75);
      img.vertex(x25, y75);
      img.vertex(x25, y100);
      img.vertex(x75, y100);
      img.vertex(x75, y25);
      img.endShape(CLOSE);

      break;
    case FOUR_WAY:
      img.beginShape();
      img.vertex(x25, y0);
      img.vertex(x25, y25);
      img.vertex(x0, y25);
      img.vertex(x0, y75);
      img.vertex(x25, y75);
      img.vertex(x25, y100);
      img.vertex(x75, y100);
      img.vertex(x75, y75);
      img.vertex(x100, y75);
      img.vertex(x100, y25);
      img.vertex(x75, y25);
      img.vertex(x75, y0);
      img.endShape(CLOSE);
      break;
    case THREE_WAY:
      img.beginShape();
      img.vertex(x0, y25);
      img.vertex(x0, y75);
      img.vertex(x25, y75);
      img.vertex(x25, y100);
      img.vertex(x75, y100);
      img.vertex(x75, y75);
      img.vertex(x100, y75);
      img.vertex(x100, y25);

      img.endShape(CLOSE);
      break;
    case END: 
      img.beginShape();
      img.vertex(x25, y25);
      img.vertex(x25, y100);
      img.vertex(x75, y100);
      img.vertex(x75, y25);
      img.endShape();
      break;
    default: 
      println("ERROR");
      stop();
    }

    img.endDraw();
  }
}
