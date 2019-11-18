


int PHYS_ID = 0;
class PhysObj {
  final int id;
  {
    PHYS_ID += 1;
    id = PHYS_ID; 
  }
  PVector pnpos,npos,pos,vel,acc;
  PVector centre;
  float w,h;
  float rotation;
  float rotationV;
  PhysObj(float x, float y) {
    this(x,y,0,0, 10,5);
  }
  
  PhysObj(float x, float y, float vx, float vy, float w, float h) {
    pos = new PVector(x,y);
    npos = pos.copy();
    pnpos = pos.copy();
    vel = new PVector(vx, vy);
    acc = new PVector();
    this.w = floor(w);
    this.h = floor(h);
    rotationV = random(-0.1,0.1);
    centre = new PVector(x + (w/2), y + (h / 2));
  }
  boolean collides(PVector pos) {
    float dist = PVector.dist(centre,pos);
    
    return dist < w;
  }
  
  
  boolean collides(PhysObj other) {
    float dist = PVector.dist(centre, other.centre);
    
    return dist < w;
  }
  
  
  void update() {
    vel.add(acc);
    vel.mult(0.999);
    pnpos.set(pos);
    boolean collision = false;
    for (float t = 0.01; t <= 1; t += 0.01) {
      npos.set(pos.x, pos.y);
      npos.add(vel.x*t,vel.y*t);
      collision = false;
      for (PhysObj brick : bricks) {
        if (brick.id != id) {
          if (brick.collides(npos)) {
            collision = true;
            break;
          }
        }
        
      }
      
      if (!collision) {
        pnpos.set(npos);  
      } else {
        break;
      }
      
    }
    
    if (collision) {
      vel.mult(-1);
      vel.mult(0.8);
    }
    rotation += rotationV;

    acc.mult(0);
    pos.set(pnpos);
    if (pos.y > height-h) {
      pos.y = height-h;
    }
    
    
  }
  
  void draw() {
    pushMatrix();
    stroke(255);
    fill(0);
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(rotation);
    rect(0,0,w,h);
    
    popMatrix();
  }
  
  void applyForce(PVector f) {
    acc.add(f);
  }
}
ArrayList<PhysObj> bricks = new ArrayList<PhysObj>();
void setup() {
  size(400,400);
  
  for (int i = 0; i < 50; i += 1) {
    bricks.add(new PhysObj(random(width), random(height), random(-5,5), random(-5,5),10,5));
  }
  
}
PVector GRAV = new PVector(0,0.1);

void draw() {
  background(0);
  for (PhysObj brick : bricks) {
    
    brick.update();
    brick.draw();
    brick.applyForce(GRAV);
  }
}
