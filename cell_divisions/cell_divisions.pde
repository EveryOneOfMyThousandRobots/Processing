ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Integer> colours = new ArrayList<Integer>();

PGraphics bg;
void setup() {
  
  
  size(400,400);
  colorMode(HSB);
  for (int i = 0; i < 5; i += 1) {
    points.add(new PVector(random(width), random(height)));
    colours.add(color(random(255),255,255));
  }
  
  bg = createGraphics(width, height);
  bg.beginDraw();
  bg.loadPixels();
  for (int x = 0; x < bg.width; x += 1) {
    for (int y = 0; y < bg.height; y += 1) {
      int closestIndex = -1;
      color closestColour = -1;
      float shortestDist = Float.MAX_VALUE;
      for (int pi = 0; pi < points.size(); pi += 1) {
        PVector p = points.get(pi);
        
        float d = sqrt(dist(x,y,p.x, p.y));
        if (closestIndex == -1 || d < shortestDist) {
          closestIndex = pi;
          closestColour = colours.get(pi);
          shortestDist = d;
        }
      }
      bg.pixels[y * bg.width + x] = closestColour;
    }
  }
  bg.updatePixels();
  bg.endDraw();
}


void draw() {
  background(0);
  image(bg, 0, 0);
  for (int pi = 0; pi < points.size(); pi += 1) {
    PVector p = points.get(pi);
    stroke(0);
    fill(colours.get(pi));
    ellipse(p.x, p.y, 5, 5);
    
  }
}
