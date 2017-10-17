class Ball {

  PVector pos, acc, vel;
  float radius = 40;

  Ball(float x, float y) {
    pos = new PVector(x, y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  }
  void draw() {
    stroke(0);
    fill(255, 50, 0);
    ellipse(pos.x, pos.y, radius, radius);
  }

  void applyForce(PVector p ) {
    acc.add(p);
  }

  void update() {
    vel.add(acc);
    vel.mult(0.99);
    float newX = pos.x + vel.x;
    float newY = pos.y + vel.y;

    if (newX >= width || newX <= 0) {
      vel.x *= -1;
    }

    if (newY >= height || newY <= 0) {
      vel.y *= -1;
    }
    
    if (newX > goal.pos.x && newX < goal.pos. x + goal.dim.x && newY > goal.pos.y && newY < goal.pos.y + goal.dim.y) {
      pos.x =random(0,width);
      pos.y = height / 2;
      vel.mult(0);   
    }



    acc.mult(0);
    pos.add(vel);
  }
}



class Goal {
  PVector pos, dim, centre;
  Goal (float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dim = new PVector(w, h);
    centre = new PVector(x + (w / 2), y + (h/ 2));
  }

  void draw() {
    stroke(0);
    noFill();
    rect(pos.x, pos.y, dim.x, dim.y);
  }
}


class Pitch {
  PVector pos, dim;
  Pitch() {
    pos = new PVector(0, 0);
    dim = new PVector(width, height);
  }

  void draw() {
    stroke(0);
    noFill();
    rect(pos.x, pos.y, dim.x, dim.y);
    line(pos.x, pos.y + (dim.y / 2), pos.x + dim.x, pos.y + (dim.y / 2)); 
  }
}

Ball ball;
Player player;
Pitch pitch;
Goal goal;
PVector up = new PVector(0, -1);
PVector down = new PVector(0, 1);
PVector left = new PVector(-1, 0);
PVector right = new PVector( 1, 0);

void setup() {
  size(400, 800);
  ball = new Ball(width / 2, height / 2);
  ball.applyForce(up.copy().mult(2));
  pitch = new Pitch();
  goal = new Goal(width / 4, 0, width / 2, height / 8);
  player = new Player(ball, goal);
  
}

void draw() {
  background(255);
  goal.draw();
  pitch.draw();
  ball.update();
  ball.draw();
  player.update();
  player.draw();
}