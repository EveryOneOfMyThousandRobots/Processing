Tile[][] tiles;
final int TS = 40;
int TA, TD;
float ns = 0.1;
float Z = 0.01;
float Zi = 0.01;

int max_frames = 120;
void setup() {
  size(800, 800);
  frameRate(30);
  TA = width / TS;
  TD = height / TS;

  tiles = new Tile[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y] = new Tile(x, y);
      
      float n = (float) x / (float) TA;
      n += (float) y / (float) TD;
      n /= 2;
      n *= 0.1;
      if (random(1) < n) {
        tiles[x][y].chosen = true;
      }
    }
  }
}
color A = color(255, 0, 0);
color B = color(255, 255, 0);

float f = 0;

void draw() {
  f = (float)(frameCount % max_frames) / (float) max_frames; 
  
  Z = map(sin(f * TWO_PI), -1, 1, 0, 1);
  background(0);
  noStroke();

  for (int x = 0; x < TA; x += 1) {

    for (int y = 0; y < TD; y += 1) {
      Tile t = tiles[x][y];
      t.update(f);
      t.draw();
      //color c = colours[x][y];
      //fill(c);
      //rect(x * TS, y * TS, TS, TS);
    }
  }
  fill(0);
  text(frameCount % max_frames, 10, 10);
}
