PVector GRAV = new PVector(0, 0.05);
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Block> blocks = new ArrayList<Block>();
//Block block;
float bw = 20;
float bh = 20;

void reset() {
  particles.clear();
  blocks.clear();
  float numAcross = width / bw;
  float numDown = height / bh;

  for (int x = 0; x < numAcross; x += 1) {
    float xx = (bw * x); 
    for (int y =0; y < numDown; y += 1) {
      float yy = (bh * y);
      Block b = new Block(xx, yy, bw, bh);
      blocks.add(b);
    }
    //  particles.add(new Particle(random(0,width), random(0,height)));
  }
}

void setup () {
  size(200, 200);
  //block = new Block(width / 2, height / 2, 20,20);
  reset();
  // frameRate(2);
}

void draw() {
  background(0);

  if (mousePressed && (mouseButton == LEFT)) {
    for (int i = 0; i < blocks.size(); i += 1) {
      Block block = blocks.get(i);
      if (mouseX >= block.x && mouseX <= block.x + block.w && mouseY >= block.y && mouseY <= block.y + block.h) {
        block.explode();
      }
    }
  } else if (mousePressed && (mouseButton == RIGHT)) {
    reset();
  }
  for (int i = 0; i < blocks.size(); i += 1) {
    Block b = blocks.get(i);
    b.draw();
  }
  for (int i = particles.size() - 1; i >= 0; i -= 1) {
    Particle p = particles.get(i);
    if (p.alive) {
      p.applyForce(GRAV);
      p.update();
      p.draw();
    } else {
      particles.remove(i);
    }
  }
}