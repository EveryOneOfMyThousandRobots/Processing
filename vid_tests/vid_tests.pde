import processing.video.*;
Movie movie;

void settings() {
  size(960, 540);
}

PGraphics bg;
float videoDuration;
float time_last, time_now;
float time_delta;
float time_accum = 0;
boolean time_enable = false;
void setup() {
  bg = createGraphics(width, height);
  bg.noSmooth();
  movie = new Movie(this, "vid.mp4");
  movie.loop();




  //make matrix

  ma = new float[SIZE][SIZE];
  float n = 1.0 / 16.0;
  for (int x = 0; x < SIZE; x += 1) {
    for (int y = 0; y < SIZE; y += 1) {

      ma[x][y] = m[x][y] * n;
    }
  }

  // size(movie.width, movie.height);
}

boolean newFrame = false;
void draw() {
  if (time_enable) {
    
    time_now = System.nanoTime() / 10e6;
    
    time_delta = time_now - time_last;
    time_accum += (time_delta / 1000);
    time_last = time_now;
  }
  if (movie.available()) {
    movie.noLoop();
  }
  background(0);
  if (newFrame) {
    bg.beginDraw();
    bg.background(0);
    bg.image(movie, 0, 0, width, height);
    bg.endDraw();
    bg = chop(bg,10,10);
    bg = chop(bg,20,20);
    bg.beginDraw();
    bg = pixelate(bg, 4);
    bg.endDraw();

    bg = dither(bg);
    bg.beginDraw();
    bg.fill(0);
    bg.noStroke();
    bg.rect(0,0,width,height/16);
    bg.rect(0,height-(height/16),width,height/16);
    bg.endDraw();
    newFrame = false;
  }
  
  image(bg, 0, 0);
  fill(255);
  text(nfc(time_accum,0), 10,10);
}

void movieEvent(Movie m) {
  m.read();
  newFrame = true;
  if (!time_enable) {
    time_enable = true;
    time_now = System.nanoTime() / 10e6;
    time_last = time_now;
    videoDuration = m.duration();
    
  }


  
}
