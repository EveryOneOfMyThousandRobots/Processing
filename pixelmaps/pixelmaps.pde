PImage img;
ArrayList<PMap> maps = new ArrayList<PMap>();
import java.util.Collections;

void setup() {
  img = loadImage("skull.jpg");
  img.loadPixels();
  size(212, 238);

  int tileHeight = 10;
  for (int y = 0; y < height; y += tileHeight) {
    if (random(10) <= 2) {
      tileHeight = (int) random(5, 12);
    }    
    PMap p = new PMap(0, y, width, tileHeight, img.pixels);
    maps.add(p);
    print(" " + maps.size());
  }
  int tileWidth = 10;
  for (int x = 0; x < width; x += tileWidth) {
    if (random(10) <= 2) {
      tileWidth = (int) random(5, 12);
    }    
    PMap p = new PMap(x, 0, tileWidth, height, img.pixels);
    maps.add(p);
    print(" " + maps.size());
  }

  println("before sort");
  for (PMap p : maps) {
    println(p.order);
  }

  Collections.sort(maps, new ComparePMaps());
  noLoop();
  println("\n\nafter sort");
  for (PMap p : maps) {
    println(p.order);
  }
}

void draw() {
  background(0);
  loadPixels();
  for (PMap p : maps) {
    p.draw();
  }
  updatePixels();
}