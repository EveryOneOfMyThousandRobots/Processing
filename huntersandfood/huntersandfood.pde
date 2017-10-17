int w = 500;
int h = 500;
long cycles = 0;
int count_hunters = 0;
int count_prey = 0;
int count_sick = 0;
long time = 0;
long lastTime = 0;
long updateCycles = 0;
long updateEveryxMillis = 500;

class Point {
  int countHunters, countPrey, countSick;
  Point(int hunters, int prey, int sick) {
    countHunters = hunters;
    countPrey = prey;
    countSick = sick;
  }
}
import java.util.Stack;
Stack<Point> points = new Stack<Point>();




int sickNeighbours(int x, int y) {
  int s = 0;
  if (isSick(x-1, y)) s += 1;
  if (isSick(x+1, y)) s += 1;
  if (isSick(x, y-1)) s += 1;
  if (isSick(x, y+1)) s += 1;
  return s;
}

boolean isSick(int x, int y) {
  C c = getAt(x, y);
  if (c != null) {
    if (c.sick > 0) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

C[][] cs;
float[][] food;
int[][] dead;

boolean surrounded(int x, int y) {
  boolean up = available(x-1, y);
  boolean down = available(x+1, y);
  boolean left = available(x, y-1);
  boolean right = available(x, y+1);

  if (!up && !down && !left && !right) {
    return true;
  } else {
    return false;
  }
}

void setup () {
  cs = new C[w][h];
  food = new float[w][h];
  dead = new int[w][h];
  for (int x = 0; x < w; x += 1) {
    for (int y = 0; y < h; y += 1) {
      food[x][y] = random(0, 5);
      int r = (int) random(0, 1000);
      C c = null;


      if (r > 980) {
        //if (x > w * 0.33 && x < w * 0.66 && y > h * 0.33 && y < h * 0.66) {
        c = new C(false, x, y );
        //}
      } else if (r ==5) {
        c = new C(true, x, y);
      }

      //if (r == 5) { //hunter;
      //  if (x < w / 2) {

      //  }
      //} else if (r > 980) {
      //  if (x > w /2) {

      //  }
      //}

      if (c != null) {
        cs[x][y] = c;
      }
    }
  }
  frameRate(10000);
}

PVector getNextAvailable(int x, int y) {
  //try up
  C c = null;

  if (available(x-1, y)) {
    return new PVector(x-1, y);
  } else if (available(x+1, y)) {
    return new PVector(x+1, y);
  } else  if (available(x, y-1)) {
    return new PVector(x, y-1);
  } else if (available(x, y+1)) {
    return new PVector(x, y+1);
  }

  return null;
}


boolean isPrey(int x, int y) {
  C c = getAt(x, y);
  if (c != null) {
    if (c.hunter == false) {
      return true;
    }
  }
  return false;
}

boolean available(int x, int y) {
  if (outOfBounds(x, y)) return false;

  C c = getAt(x, y);
  if (c != null) {
    return false;
  }
  return true;
}

boolean outOfBounds(int x, int y) {
  if (x < 0 || x >= w || y < 0 || y >= h) {
    return true;
  }
  return false;
}

C getAt(int x, int y) {
  if (!outOfBounds(x, y)) {
    return cs[x][y];
  }

  return null;
}

void settings() {
  size(w*2, h*2);
}

void draw() {
  time = millis();
  //boolean addPoint = false;
  boolean drawText = false;
  if (time > lastTime + updateEveryxMillis || lastTime == 0) {
    lastTime = time;
    drawText = true;
    updateCycles = cycles;
    count_hunters = 0;
    count_prey = 0;
    count_sick = 0;
    //addPoint = true;
  }
  cycles += 1;
  // int hhh =0, nhhh=0;
  //boolean draw = false;
  //if (frameCount % 50 == 0 || frameCount == 1) {
  if (drawText) {
    background(0);
    loadPixels();
  }
  //  draw = true;
  //  }
  for (int x = 0; x < w; x += 1) {
    for (int y = 0; y < h; y += 1) {
      color col = color(map(food[x][y], 0, 5, 0, 64));
      if (drawText) {
        setPixel(x, y, col);
      }
      //pixels[x + y * w] = col;      
      C c = cs[x][y];
      //float f = food[x][y];
      //stroke(map(f, 0, 5, 0, 128));
      //point(x,y);
      if (c != null) {
        if (drawText) {
          if (c.hunter) {
            count_hunters += 1;
          } else {
            count_prey += 1;
            if (c.sick > 0) {
              count_sick += 1;
            }
          }
        }
        c.move();
        //    if (draw) c.draw();
        if (drawText) {
          c.draw();
        }

        //set(c.x, c.y, color(255));
      }
      food[x][y] += random(0.001, 0.03);
      if (food[x][y] > 5) food[x][y] = 5;

      if (dead[x][y] > 0) {
        if (drawText) {
          setPixel(x, y, color(255, 0, 0));
        }
        // pixels[x + y * w] = color(255,0,0);
        dead[x][y] -= 1;
      }
    }
  }
  if (drawText) {
    points.push(new Point(count_hunters, count_prey, count_sick));
    if (points.size() >= width) {
      points.remove(0);
      //for (int i = width / 2; i >= 0; i -= 1) {

      //}
    }
  }

  if (drawText) {
    updatePixels();
    noStroke();
    fill(0,200);
    rect(0, 0, 150, 15);
    //drawPoints
    rect(0, (height - 150.0), width, 150);
    int i = 0;
    int highest = 0;
    for (Point p : points) {
      if (p.countHunters > highest) {
        highest = p.countHunters;
      }
      if (p.countPrey > highest) {
        highest = p.countPrey;
      }

      if (p.countSick > highest) {
        highest = p.countSick;
      }
    }
    loadPixels();
    for (Point p : points) {
      i += 1;
      float x = map(i, 0, points.size(), 0, w);
      float y = map(p.countHunters, 0, highest, h, h- 75);

      setPixel(x, y, color(255, 255, 128));

      y = map(p.countPrey, 0, highest, h, h-75);
      setPixel(x, y, color(255));

      if (p.countSick > 0) {
        y = map(p.countSick, 0, highest, h, h-75);
        setPixel(x, y, color(0, 255, 0));
      }
    }
    updatePixels();

    fill(255);
    stroke(255);
    text(updateCycles + ": " + count_hunters + "/" + count_prey, 10, 10);
    fill(0);
    stroke(0);
    rect(0, height - 150, 150, 15);
    fill(255);
    stroke(255);
    text(highest, 10, height - 140);
    if (count_hunters == 0 || count_prey == 0) {
      stop();
      println("finished after " + cycles + " cycles");
    }
  }
}

void setPixel(int x, int y, color c) {
  int xx = x * 2;
  int yy = y * 2;
  if (xx < 0 || xx >= width || yy < 0 || yy > height ) return;
  pixels[ xx + yy * width] = c;
  pixels[ (xx+1) + yy * width] = c;
  pixels[ xx + (yy+1) * width] = c;
  pixels[ (xx+1) + (yy+1) * width] = c;
}

void setPixel(float x, float y, color c) {
  setPixel((int)x, (int)y, c);
}