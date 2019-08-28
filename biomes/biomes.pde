int[][] map;




ArrayList<Biome> biomes; 
HashMap<Integer, Biome> lookup = new HashMap<Integer, Biome>();

void setup() {
  size(800, 800);
  colorMode(HSB);
  reset();
}

void reset() {
  biomes = new ArrayList<Biome>();
  map = new int[width][height];
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      map[x][y] = 0;
    }
  }
  int ts = 50;
  int across = width / ts;
  int down = height / ts;
  for (int i = 0; i < 20; i += 1) {
    int xs = floor(random(across)) * ts;
    int ys = floor(random(down)) * ts;
    int xe = xs;
    int ye = ys;
    if (random(1) < 0.5) {
      xe = floor(random(xs+1,width));
      xe -= xe % ts;
    } else {
      ye = floor(random(ys+1,height));
      ye -= ye % ts;
    }
    
    for (int x = xs; x <= xe; x += 1) {
      //if (random(1) < 0.008) continue;
      for (int y = ys; y <= ye; y += 1) {
        //if (random(1) < 0.008) continue;
        map[x][y] = 1000;
      }
    }
  }

  for (int i = 0; i < 10; i += 1) {
    biomes.add(new Biome(color(random(255), 255, 255)));
  }
}

int sumToCheckSize;
float avgTC = 0;
void draw() {
  background(0);

  loadPixels();
  for (int i = 0; i < 100; i += 1) {
    sumToCheckSize = 0;
    for (Biome b : biomes) {
      b.update();
      sumToCheckSize += b.toCheck.size();
    }
    avgTC = (float)sumToCheckSize / (float)biomes.size();
  }
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      int v = map[x][y];
      if (v != 0 ) {
        if (lookup.containsKey(v)) {
          Biome b = lookup.get(v);

          if (b != null) {

            pixels[y * width + x] = b.c;
          }
        }
      }
    }
  }
  updatePixels();
  text(nfc(avgTC, 0), 10, 10);
}

void mouseClicked() {
  reset();
}
