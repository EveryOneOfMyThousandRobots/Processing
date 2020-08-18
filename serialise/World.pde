class World {
  Tile[][] tiles;
  final int TILE_SIZE;
  final int TA; 
  final int TD;

  World(int tileSize) {
    TILE_SIZE = tileSize;
    TA = width / tileSize;
    TD = height / tileSize;

    tiles = new Tile[TA][TD];

    for (int x = 0; x < TA; x += 1) {
      for (int y = 0; y < TD; y += 1) {
        color c = color(random(255), random(255), random(255));
        Tile t = new Tile(x, y, c);
        tiles[x][y] = t;
      }
    }
  }

  void saveWorld(String fileName) {
    long start = System.nanoTime();
    OutputStream s = createOutput(fileName);

    try {
      writeSegmentStart(s, "WORLD");
      writeKV(s, "TILE_SIZE", str(TILE_SIZE));
      writeKV(s, "TILE_ACROSS", str(TA));
      writeKV(s, "TILE_DOWN", str(TD));
      writeSegmentStart(s, "TILES");
      for (int x = 0; x < TA; x += 1) {
        for (int y = 0; y < TD; y += 1) {
          tiles[x][y].saveTile(s);
        }
      }
      writeSegmentEnd(s, "TILES");
      writeSegmentEnd(s,"WORLD");
      s.close();
    } 
    catch (Exception e ) {
      println(e.getMessage());
    }
    long end = System.nanoTime();
    
    float elapsed = end - start;
    elapsed /= 1000000000.0;
    
    println("finished in " + (nfc(elapsed,4)) + " seconds");
  }



}
