import fisica.*;

FWorld world;

void setup() {
  size(400, 400);
  Fisica.init(this);
  // world = new VerletPhysics2D();
  world = new FWorld();
  world.setEdges();
  FBox boxa = new FBox(20, 20);
  FBox boxb = new FBox(20, 20);
  boxb.setPosition((width / 2)+20, height / 2);
  boxa.setPosition(width / 2, height / 2);
  boxa.setAngularVelocity(1);
  FPrismaticJoint j = new FPrismaticJoint(boxa, boxb);
  world.add(boxa);
  world.add(boxb);
  world.add(j);


  FBlob blob = new FBlob();
  float a = TAU / 6;
  float r = 20;
  for (int i = 0; i < 6; i += 1) {
    float x = r * cos(a * i);
    float y = r * sin(a * i);

    blob.vertex(x, y);
  }
  blob.setPosition(width / 2, (height / 2) - 50);
  FPrismaticJoint ja = new FPrismaticJoint(blob, boxb);
  world.add(blob);
  world.add(ja);

  for (Object o : world.getBodies()) {
    println(o);
  }
}

void draw() {
  background(0);
  world.step();
  world.draw();
}