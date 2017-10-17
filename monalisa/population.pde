class Population {
  ArrayList<ArrayList<ArrayList<Chunk>>> chunks = new ArrayList<ArrayList<ArrayList<Chunk>>>();
  int tileSize = 20;

  Population(int size) {

    for (int x = 0; x < original.width; x += tileSize) {
      ArrayList<ArrayList<Chunk>> row = new ArrayList<ArrayList<Chunk>>();
      for (int y = 0; y < original.height; y += tileSize) {

        //int xx = x * tileSize;
        //int yy = y * tileSize;
        ArrayList<Chunk> bits = new ArrayList<Chunk>();
        for (int i = 0; i < size; i += 1) {
          Chunk chunk = new Chunk(x, y, tileSize, tileSize, original.width, 0);
          bits.add(chunk);
        }
        row.add(bits);
      }
      chunks.add(row);
    }
  }
  
  void draw() {
    
  }
}