class Tile {
  TileType type = TileType.GRASS;
  PVector pos;
  final int xi, yi;

  ArrayList<Tile> neighbourList;
  HashMap<String,Tile> neighbourMap;
  

  Tile(int x, int y) {
    this.xi = x;
    this.yi = y;
    neighbourList = new ArrayList<Tile>();
    neighbourMap = new HashMap<String,Tile>();
    pos = new PVector(x * TILE_SIZE, y * TILE_SIZE);
  }
  
  
  Tile getNeighbour(String dir) {
    if (neighbourMap.containsKey(dir)) {
      return neighbourMap.get(dir);
    } else {
      return null;
    }
  }
  
  void setNeighbours() {
    neighbourList.clear();
    neighbourMap.clear();
    setNeighbour(north,xi,yi-1);
    setNeighbour(east,xi+1,yi);
    setNeighbour(south,xi,yi+1);
    setNeighbour(west,xi-1,yi);
    
    
    
    
  }
  
  void setNeighbour(String dir, int nx, int ny) {
    Tile n = getTile(nx, ny);
    if (n!= null) {
      neighbourList.add(n);
      neighbourMap.put(dir,n);
    }
    
  }
  
  void draw() {
    
    
  }
}
