import java.util.Collections; //<>// //<>//
final int TILE_SIZE = 10;
final float TILE_SIZE_FLOAT = TILE_SIZE;
final int NUM_TILES_ACROSS = 64;
final int NUM_TILES_DOWN = 36;

boolean show = false;

Particle prt;

Tile[][] tiles;

void settings() {
  size(TILE_SIZE * NUM_TILES_ACROSS, TILE_SIZE * NUM_TILES_DOWN);
}

void setup() {
  tiles = new Tile[NUM_TILES_ACROSS][NUM_TILES_DOWN];

  for (int x = 0; x < NUM_TILES_ACROSS; x += 1) {
    tiles[x][0] = new Tile(x, 0, true);
    tiles[x][NUM_TILES_DOWN-1] = new Tile(x, NUM_TILES_DOWN-1, true);
  }

  for (int y = 0; y < NUM_TILES_DOWN; y += 1) {
    tiles[0][y] = new Tile(0, y, true);
    tiles[NUM_TILES_ACROSS-1][y] = new Tile(NUM_TILES_ACROSS-1, y, true);
  }
  prt = new Particle();
  setNeighbours();
}

void setNeighbours() {
  println("set neighbours");
  for (int x = 0; x < NUM_TILES_ACROSS; x += 1) {
    for (int y = 0; y < NUM_TILES_DOWN; y += 1) {
      Tile t = getTileAt(x, y);
      if (t != null) {
        t.setNeighbours();
      }
    }
  }

  calcEdges();
  prt.setRays();

  Float r = random(0, 1);
  Float b = r;
  println(r + " " + nfc(r, 3).hashCode());
  println(b + " " + nfc(b, 3).hashCode());
  //prt.s/etRays();
}
ArrayList<RData> rays = new ArrayList<RData>();

void draw() {

  background(0);
  if (show) {
    prt.update();

    createRayData();
    prt.setRays();

    prt.draw();
  }
  for (int x = 0; x < NUM_TILES_ACROSS; x += 1) {
    for (int y = 0; y < NUM_TILES_DOWN; y += 1) {

      Tile t = tiles[x][y];

      if (t != null) {
        t.draw();
      }
    }
  }
  fill(255);
  text(wantedToAdd + " " + actuallyAdded, 10, 10);
  for (Edge e : edgeList) {
    e.draw();
  }

  //for (RData r : rays) {
  //  println(r);
  //}
}

PVector mStart = new PVector();
PVector mEnd = new PVector();
void mousePressed() {
  if (mouseButton == LEFT) { 
    mStart.set(mouseX, mouseY);
  } else if (mouseButton == RIGHT) {
    show = true;
  }
}
void mouseDragged() {
  //addTileAtMouse();
}

void mouseReleased() {
  if (mouseButton == LEFT) { 
    mEnd.set(mouseX, mouseY);
    addTileAtMouse();
  } 
  if (mouseButton == RIGHT) {
    show = false;
  }
}

void addTileAtMouse() {


  float dist = PVector.dist(mStart, mEnd);

  if (dist < TILE_SIZE_FLOAT) {
    toggleTileAt(mStart.x, mStart.y);
  } else {
    float angle = PVector.angleBetween(mStart, mEnd);
    PVector p = PVector.sub(mEnd, mStart);
    p.normalize();
    p.mult(TILE_SIZE_FLOAT);
    PVector a  = PVector.fromAngle(angle);
    a.mult(TILE_SIZE_FLOAT);

    PVector from = mStart.copy();

    while (dist > TILE_SIZE_FLOAT) {

      toggleTileAt(from.x, from.y);
      from.add(p);
      dist = PVector.dist(from, mEnd);
    }
    toggleTileAt(mEnd.x, mEnd.y);
  }

  setNeighbours();
}

void toggleTileAt(float x, float y) {

  int xx = floor(x / TILE_SIZE_FLOAT);
  int yy = floor(y / TILE_SIZE_FLOAT);
  //println(x + "," + y);
  if (!valid(xx, yy)) return;
  Tile t = tiles[xx][yy];

  if (t == null) {
    tiles[xx][yy] = new Tile(xx, yy, false);
  } else if (!t.fixed) {
    tiles[xx][yy] = null;
  }
}
