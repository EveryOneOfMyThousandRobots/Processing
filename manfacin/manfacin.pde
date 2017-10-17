class Man {
  PVector pos;
  PVector facing;
  float angle;
  float speed;
  int points;
  float viewAngle = radians(50);
  float viewRange = 100;
  PVector hPos, hDim;
  float radius;
  PVector target = null;
  PVector edge = null;

  Man(float x, float y, float radius) {
    this.radius = radius;
    this.pos = new PVector(x, y);
    this.hPos = new PVector(pos.x - (radius / 2), pos.y - (radius / 2));
    this.hDim = new PVector(radius, radius);
    angle = 0;
    facing = PVector.fromAngle(angle);
    speed = 1;
    edge = new PVector(width, height);
  }



  void look() {
    PVector look;
    PVector look2;
    boolean collides = false;
    for (float a = angle - viewAngle; a < angle + viewAngle; a += radians(5)) {
      collides = false;
      look = PVector.fromAngle(a);
      PVector pp = look.copy();
      pp.normalize();
      look2 = pp.copy();
      for (float p = 1; p <= viewRange; p += 1) {
        //look2 = look.copy();
        look2.add(pp.x, pp.y);
        for (Obstacle b : blocks) {
          if (b.collides(pos.x + look2.x, pos.y + look2.y)) {
            collides = true;
            break;
          }
        }
        if (collides) break;
        point(pos.x + look2.x, pos.y + look2.y);
        //  point(look2.x, look2.y);
        // pixels[floor(look2.x) + floor(look2.y) * width] = color(255);
      }
      //point(pos.x + look2.x, pos.y + look2.y);
    }
  }


  void draw() {

    stroke(255);
    fill(255, 0, 0);
    rect(hPos.x, hPos.y, hDim.x, hDim.y);
    fill(0);
    ellipse(pos.x, pos.y, radius, radius);
    PVector f = facing.copy();
    f.mult(10);
    line(pos.x, pos.y, pos.x + f.x, pos.y + f.y);
    
    if (target != null) {
      rect(target.x, target.y, 10,10);
    }
    // look();
  }

  void update() {
    if (target != null) {
      if (PVector.dist(pos, target) < radius) {
        target = null;
      } else {
        //PVector edge1 = new PVector(width, target.y);
        //PVector edge2 = new PVector(width, pos.y);
        angle =  PVector.sub(target, pos).heading();
       // facing = PVector.fromAngle(angle);
        
      }
    }


    PVector m = facing.copy();
    m.mult(speed);
    boolean bump = false;
    for (Obstacle o : blocks) {
      if (o.collides(hPos.x + m.x, hPos.y + m.y, hDim.x, hDim.y)) {
        bump = true;
        break;
      }
    }
    if (!bump) {
      pos.add(m);
      hPos.add(m);
      if (random(0, 10) <= 2) {
        angle += radians(random(-0.5, 0.5));
      }
    } else {


      angle += radians(1);
    }
    if ( angle > TWO_PI) {
      angle -= TWO_PI;
    }

    facing = PVector.fromAngle(angle);
  }
}

Man man;
ArrayList<Obstacle> blocks = new ArrayList<Obstacle>();
void setup() {
  size(500, 500);
  man = new Man(width / 2, height / 2, 10);

  blocks.add( new Obstacle(0, 0, width, 10));
  blocks.add( new Obstacle(0, 0, 10, height));
  blocks.add( new Obstacle(0, height-10, width, 10));
  blocks.add( new Obstacle(width - 10, 0, 10, height));
  for (int i = 0; i < 10; i += 1) {
    int x = (int) random(20, width - 20);
    x = 20 + ((x / 20) * 20);
    int y = (int) random(20, height - 20);
    y = 20 + ((y / 20) * 20);

    blocks.add( new Obstacle(x, y, 20, 20));
  }
}

void draw() {
  background(0);

  for (Obstacle b : blocks ) {
    b.draw();
  }
  man.update();
  //loadPixels();
  man.look();
  //updatePixels();  
  man.draw();
}

void mouseClicked() {
  man.target = new PVector(mouseX, mouseY);
}