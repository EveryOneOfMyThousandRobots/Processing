import java.util.*;



PImage bg;
PGraphics img;
HashMap<Integer, Integer> colourMap = new HashMap<Integer, Integer>();
final int RES = 4;

void settings() {
  bg = loadImage("pea.jpg");
  size(bg.width*RES, bg.height*RES);
  noSmooth();
}

final int colours = 8;

class P {
  int x, y;
  boolean fixed = false;
  color c;
  P(int x, int y, color c, boolean fixed) {
    this.x = x;
    this.y = y;
    this.fixed = fixed;
    this.c = c;
  }
}
P[][] grid;
P[][] nextFrame;

color roundColour(color c) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);

  r = int(r / (255/colours)) * (255/colours);
  g = int(g / (255/colours)) * (255/colours);
  b = int(b / (255/colours)) * (255/colours);

  c = color(r, g, b);

  return c;
}

void setup() {
  //size(200, 200);

  img = createGraphics(bg.width, bg.height);
  grid = new P[bg.width][bg.height];


  bg.loadPixels();
  for (int x = 0; x < bg.width; x += 1) {
    for (int y = 0; y < bg.height; y += 1) {
      color c = bg.pixels[y * bg.width + x];

      c = roundColour(c);

      if (colourMap.containsKey((int)c)) {
        int count = colourMap.get((int)c);
        count += 1;
        colourMap.put((int)c, count);
      } else {
        colourMap.put((int)c, 1);
      }
    }
  }



  //Map<Integer,Integer> sorted = colourMap.entrySet().stream().sorted(Map.Entry.comparingByValue()).collect(
  //toMap(Map.Entry::getKey, Map.Entry::getValue, (e1,e2) -> e2, LinkedHashMap::new));
//  HashMap<Integer, Integer> sorted = sortByValue(colourMap);
  ArrayList<Integer> keys = new ArrayList<Integer>(colourMap.keySet());

  for (int i = keys.size()-1; i >= 0; i -= 1) {
    color c = keys.get(i);
    println(Integer.toHexString(c) + " b=" + brightness(c)); 
    if (brightness(c) < 32) {
      keys.remove(i);
    }
    
  }

  //  while (sorted.size() > colours/4) {
  ArrayList<Integer> keepColours = new ArrayList<Integer>();
  ArrayList<Integer> fixedColours = new ArrayList<Integer>();
  for (int i = 0; i < keys.size(); i += 1) {
    //int i = floor(random(keys.size()));
    int r = floor(random(4));
    if (r <= 1) {
    } else if (r == 2) {
      keepColours.add(keys.get(i));
    } else {
      fixedColours.add(keys.get(i));
      
    }
  }




  //for (int i : colourMap.keySet()) {
  //  println(Integer.toHexString(i) + ": " + colourMap.get(i));
  //}



  for (int x = 0; x < bg.width; x += 1) {
    for (int y = 0; y < bg.height; y += 1) {
      color c = bg.pixels[y * bg.width + x];
      c = roundColour(c);
      if (!keepColours.contains(c) && !fixedColours.contains(c)) continue;
      boolean fixed = (fixedColours.contains(c));
      grid[x][y] = new P(x, y, c, fixed);
    }
  }
}


boolean OOB(int x, int y) {
  return x < 0 || x > bg.width-1 || y < 0 || y > bg.height-1;
}


P grid_get(int x, int y) {
  if (OOB(x, y)) return null;

  return grid[x][y];
}

void update() {
  nextFrame = new P[bg.width][bg.height];

  for (int x = 0; x < bg.width; x += 1) {
    for (int y = bg.height-1; y >= 0; y -= 1) {
      P p = grid_get(x, y);
      if (p != null) {
        if (p.fixed) {
          nextFrame[x][y] = p;
        } else {
          P left = grid_get(x-1, y+1);
          P down = grid_get(x, y+1);
          P right = grid_get(x+1, y+1);

          if (down == null && !OOB(x, y+1)) {
            nextFrame[x][y+1] = p;
            grid[x][y] = null;
          } else if (left == null && !OOB(x-1, y+1)) {
            nextFrame[x-1][y+1] = p;
            grid[x][y] = null;
          } else if (right == null && !OOB(x+1, y+1)) {
            nextFrame[x+1][y+1] = p;
            grid[x][y] = null;
          } else {
            nextFrame[x][y] = p;
          }
        }
      }
    }
  }

  grid = nextFrame;
}


void draw() {
  img.beginDraw();
  img.background(51);
  img.loadPixels();
  for (int x = 0; x < bg.width; x += 1) {
    for (int y = 0; y < bg.height; y += 1) {
      P p =  grid_get(x, y);
      if (p != null) {

        img.pixels[y * img.width + x] = p.c;
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0, width, height);
  update();
}
