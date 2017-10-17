class Tile {
  float x, y;
  float w, h;
  color c = color(255);//color(random(255), random(255), random(255));
  Tile (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    float r = map((x * y) % width, 0, width, 0, 255);
    float g = map((x / (y + 1)) % width, 0, width, 0, 255);
    float b = map(x + y % width, 0, width, 0, 255);
    c = color(r, g, b);
  }

  void draw() {
    fill(c);
    noStroke();//stroke(0);
    rect(x, y, w, h);
  }
}

class Tiles {
  private ArrayList<Tile> tiles = new ArrayList<Tile>();
  void add(Tile t) {
    tiles.add(t);
  }

  Tile getTile(float x, float y) {
    int index = getTileIndex(x, y);
    if (index >= 0 && index < tiles.size()) {
      return tiles.get(index);
    } else {
      return null;
    }
  }

  int getTileIndex(float x, float y) {
    int index = -1;
    int xx = (int)(x / tileWidth);
    int yy = (int)(y / tileHeight);
    int ww = (int)(width / tileWidth);
    index = xx + yy * ww;

    return index;
  }

  void draw() {
    for (int i = 0; i < tiles.size(); i++) {
      Tile t = tiles.get(i);
      t.draw();
    }
  }
}

class Tracer {
  ArrayList<Tile> path = new ArrayList<Tile>();
  ArrayList<Tile> fullPath = new ArrayList<Tile>();
  final int UP = 0, DOWN = 1, LEFT = 2, RIGHT = 3;
  int prevDir = -1;
  float x, y;

  Tracer(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    getNext();
  }

  void draw() {

    if (path.size() > 1) {
      Tile top = path.get(path.size() - 1);


      Tile last = path.get(0);

      for (int i = 1; i < path.size(); i++) {
        Tile t = path.get(i);
        stroke(255);

        float x1 = last.x + (last.w / 2);
        float y1 = last.y + (last.h / 2);
        float x2 = t.x + (t.w / 2);
        float y2 = t.y + (t.h / 2);
        line(x1, y1, x2, y2);
        last = t;
      }
      noStroke();
      fill(255);      
      ellipse(top.x + top.w / 2, top.y + top.h / 2, tileWidth / 2, tileHeight / 2);
    }
  }

  private void getNext() {
    int nextDir = 0;
    float newX = 0;
    float newY = 0;
    if (path.size() > 0) {
    }
    while (true) {
      nextDir = ((int) random(0, 1000)) % 4 ;


      if ((prevDir == UP && nextDir == DOWN) || (prevDir == DOWN && nextDir == UP) || (prevDir == LEFT && nextDir == RIGHT) || (prevDir == RIGHT && nextDir == LEFT)) {
      } else {

        break;
      }
    }

    switch( nextDir) {
    case UP:
      newX = x;
      newY = y - tileHeight;
      break;
    case DOWN:
      newX = x;
      newY = y + tileHeight;    
      break;

    case LEFT:
      newX = x -tileWidth ;
      newY = y;    
      break;
    case RIGHT:
      newX = x + tileWidth;
      newY = y;       
      break;
    default:
      break;
    }

    if (newX < 0 || newX >= width || newY < 0 || newY >= height) {
    } else {

      Tile t = tiles.getTile(newX, newY);
      if (t != null) {
        if (!path.contains(t) && !fullPath.contains(t)) {
          x = t.x;
          y = t.y;
          t.c = color(0);

          path.add(t);
          fullPath.add(t);
          prevDir = nextDir;
        } else {
          if (path.size() == 0) {
            Tile tt = path.remove(path.size() - 1);
            tt = path.get(path.size() - 1);
            x = tt.x;
            y = tt.y;
          }
        }
      }
    }
  }
}


float tileWidth = 8;
float tileHeight = 8;
Tiles tiles;
Tracer tracer;
void setup() {
  size(600, 600);
  tiles = new Tiles();
  tracer = new Tracer(width / 2, height / 2);
  for (float y = 0; y < height; y += tileHeight) {
    for (float x = 0; x < width; x += tileWidth) {

      tiles.add(new Tile(x, y, tileWidth, tileHeight));
    }
  }
  // frameRate(5);
}

void draw() {
  background(0);
  tiles.draw();
  tracer.update();
  tracer.draw();
}

void mouseClicked() {

  println(tiles.getTileIndex(mouseX, mouseY));
}