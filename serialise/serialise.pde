class Tile {
  int x, y;
  color c;

  Tile(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void saveTile(OutputStream s) throws Exception {
    writeSegmentStart(s, "TILE");
    writeKV(s, "x", str(x));
    writeKV(s, "y", str(y));
    writeKV(s, "c", Integer.toHexString(c));
    writeSegmentEnd(s, "TILE");
  }

  String toSaveString() {
    String saveString = "::TILE";

    saveString = strAppendKV(saveString, "x", str(x));
    saveString = strAppendKV(saveString, "y", str(y));
    saveString = strAppendKV(saveString, "c", Integer.toHexString(c));


    return saveString;
  }
}



World world;

void setup() {
  size(800, 800);
  world = new World(10);
  //String ws = world.toSaveString();
  world.saveWorld("test.gz");

  exit();
}

void draw() {
}
