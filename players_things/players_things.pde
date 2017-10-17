class DrawableThing {
  float x, y;
  float r;
  color col;

  DrawableThing(float x, float y, float r, color col) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.col = col;
  }

  void draw() {
    fill(col);
    stroke(0);
    ellipse(x, y, r, r);
  }
}


class Player {
  DrawableThing drawable = new DrawableThing(random(0, width), random(0, height), 10, color(64, 64, 64));
  float facing;
  Brain brain = new Brain();
  
  void update() {
    
  }

  void draw() {
    drawable.draw();
  }
}

class Ball {
  DrawableThing drawable = new DrawableThing(width / 2, height / 2, 10, color(255, 0, 0));
  void draw() {
    drawable.draw();
  }
}

class Pitch {
  void draw() {
    noStroke();
    fill(0,64,10);
    rect(0,0,width,height);
  }
}

Player p;
Ball b;
Pitch pitch;

void setup () {
  p = new Player();
  b = new Ball();
  pitch = new Pitch();
  size(400, 400);
}

void draw() {
  background(255);
  pitch.draw();
  p.draw();
  b.draw();
}