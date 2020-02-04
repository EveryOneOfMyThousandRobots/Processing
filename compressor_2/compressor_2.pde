HashMap<Integer, Map> maps = new HashMap<Integer, Map>();

final int W = 4;
final int H = 4;
final int SIZE = W * H;
final int NUM = 256;
final int COLOUR_FACTOR = floor(255.0/7.0);
final int PER_FRAME_ITERATIONS = 250;
PImage bg;
PGraphics post;
int[][] indexMap;
void settings() {
  bg = loadImage("morefaces.jpg");
  size(bg.width * 2, bg.height);
  noSmooth();
}
void setup() {
  //size(800, 800);

  post = createGraphics(bg.width, bg.height);
  indexMap = new int[bg.width / W][bg.height / H];

  generateMaps();
  proc();

  //noLoop();
}

void generateMaps() {
  for (int i = 0; i < NUM; i += 1) {
    Map map = new Map(i);
    map.generate();
    maps.put(i, map);
  }

  for (int n = 0; n < 512; n += 1) {
    replaceOne();
  }
}

void replaceOne() {
  ArrayList<Integer> keys = new ArrayList<Integer>(maps.keySet());
  int idx = keys.get(floor(random(keys.size())));

  Map map = new Map(idx);
  map.generate();
  maps.put(idx, map);
}





void draw() {
  background(0);
  image(bg, 0, 0);
  image(post, post.width, 0);
  for (int i = 0; i < PER_FRAME_ITERATIONS; i += 1) {
    proc();
  }
}

void redrawPost() {
  post.beginDraw() ;
  for (int x = 0; x < indexMap.length; x += 1) {
    for (int y = 0; y < indexMap[x].length; y += 1) {
      post.image(maps.get(indexMap[x][y]).pg, x * W, y * H);
    }
  }
  post.endDraw();
}


void mouseReleased() {
  glo_x = 0;
  glo_y = 0;
  generateMaps();
  redrawPost();
}
