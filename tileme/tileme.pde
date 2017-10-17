int tilesAcross, tilesDown;
int tileSize = 15;
int num_workers = 50;
int successes = 0;

Tile[][] tiles;
ArrayList<WorkTile> workTiles = new ArrayList<WorkTile>();
ArrayList<Worker> workers = new ArrayList<Worker>();
Stack<Instruction> bad = new Stack<Instruction>();

void setup() {
  size(600, 600, P2D);
  colorMode(HSB); 
  textFont(createFont("Consolas", 10));

  tilesAcross = width / tileSize;
  tilesDown = height / tileSize;
  tiles = new Tile[tilesAcross][tilesDown];


  for (int x = 0; x < tilesAcross; x += 1) {
    for (int y = 0; y < tilesDown; y += 1) {
      Tile t = new Tile(x * tileSize, y * tileSize, x, y);
      tiles[x][y] = t;
      if (random(1) < 0.03) {
        WorkTile w = new WorkTile(t);
        t.setWorkTile(w);
        workTiles.add(w);
        
      }
    }
  }
  
  for (int i = 0; i < num_workers; i += 1) {
    workers.add(new Worker());
  }
}

void draw() {
  background(0);
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }
  
  for (WorkTile wt : workTiles) {
    wt.update();
    wt.draw();
  }
  
  for (Worker w : workers) {
    w.update();
    w.draw();
  }
  text(successes, 10,10);
}