import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Barrier> barriers = new ArrayList<Barrier>();
ArrayList<Box> boxes = new ArrayList<Box>();

Box2DProcessing  world;





void setup() {
  size(500, 500);
  world = new Box2DProcessing(this);
  world.createWorld();


  BodyDef ground = new BodyDef();
  //ground.position.set(world.scalarPixelsToWorld(width / 2), world.scalarPixelsToWorld(height / 2));
  ground.position.set(world.coordPixelsToWorld(0, height+10));
  //ground.position.set(0,0);
  Body gb = world.createBody(ground);
  PolygonShape gbox = new PolygonShape();
  gbox.setAsBox(world.scalarPixelsToWorld(width), world.scalarPixelsToWorld(10));
  gb.createFixture(gbox, 0);

  //box.createBody();
  float yy = 50;
  for (float y = yy; y < height; y += yy) {
    barriers.add(new Barrier(random(width), y, width / 8, 20));
  }

  //for (float y = yy; y < height; y += yy) {
  //  barriers.add(new Barrier(width - (width / 4), y, width / 8, 20));
  //}
  println(barriers.size());
}

void draw() {
  background(255);
  world.step();

  for (Barrier b : barriers) {
    //println(b.body.getPosition());
    b.draw();
  }

  for () {
    b.draw();
  }
  
  if (mousePressed) {
    makeBoxes();
  }
}


void makeBoxes() {
  float rn = floor(random(1,10));
  float rd = random(10, 20);
  float ai = TWO_PI / rn;
  for (float a = 0; a < TWO_PI; a += ai) {
    float aa = a + radians(random(-5, 5));
    float rr = rd + random(-2, 2);
    float xx = mouseX + rr * cos(aa);
    float yy = mouseY + rr * sin(aa);
    boxes.add(new Box(xx, yy, 5, 5));
    println(a);
  }
}
