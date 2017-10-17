PImage img;

class Chunk {

  float x, y;
  float w, h;
  Chunker chunker;
  private PImage myImg;
  float bri = 0;
  Chunk(float x, float y, float w, float h, Chunker chunker) {

    this.x = floor(x);
    this.y = floor(y);
    this.w = floor(w);
    this.h = floor(h);
    this.chunker = chunker;
    myImg = chunker.testImg;
  }


  void eval() {
    float average = 0;
    for (float xx = x; xx < x + w; xx += 1) {
      for (float yy = y; yy < y + h; yy += 1) {
        average += brightness(myImg.get(floor(xx), floor(yy)));
      }
    }
    average /= (w * h);
    bri = average;
  }
}
class Chunker {
  PImage testImg;
  ArrayList<Chunk> chunks = new ArrayList<Chunk>();
  float x, y, w, h;
  float xoff, yoff;

  Chunker(PImage img) {
    testImg = img;
    testImg.loadPixels();
    x = 0;
    y = 0;
    w = img.width;
    h = img.height;
    xoff = img.width;
    yoff = 0;
    chunks.add( new Chunk(0, 0, w, h, this));
  }

  void update() {

    ArrayList<Chunk> newchunks = new ArrayList<Chunk>();
    

    for (int i = 0; i < chunks.size(); i += 1) {
      Chunk c = chunks.get(i);
      

      if (c.w > c.h) {
        newchunks.add(new Chunk(c.x + (c.w / 2), c.y, c.w / 2, c.h, this));
        newchunks.add(new Chunk(c.x, c.y, c.w / 2, c.h, this));
      } else {
        newchunks.add(new Chunk(c.x, c.y, c.w, c.h / 2, this));
        newchunks.add(new Chunk(c.x, c.y + (c.h / 2), c.w, c.h / 2, this));
      }
    }
    chunks = newchunks;
    for (Chunk c : chunks) {
      c.eval();
    }
  }


  void draw() {
    noStroke();
    for (Chunk chunk : chunks) {
      fill(chunk.bri);
      
      rect(xoff + chunk.x, yoff + chunk.y, chunk.w, chunk.h);
    }
  }
}

Chunker chunker;
void setup() {
  chunker = new Chunker(img);
}

void settings() {
  img = loadImage("mona.png");
  size(img.width * 2, img.height * 2);
}

void draw() {
  background(0);
  image(img, 0, 0);
  
  chunker.draw();
}

void mouseClicked() {
  chunker.update();
}