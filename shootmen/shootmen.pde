

void setup() {
  size(800, 600);

  blocks.add(new Obstacle(0, 0, BARRIER_W, height));
  blocks.add(new Obstacle(0, 0, width, BARRIER_H));
  blocks.add(new Obstacle(0, height-BARRIER_H, width, BARRIER_H));
  blocks.add(new Obstacle(width - BARRIER_W, 0, BARRIER_W, height));
  for (float y = BARRIER_H; y < height - BARRIER_W; y += BARRIER_H * 3) {
    for (float x = BARRIER_W; x < width - BARRIER_W; ) {

      if (random(1) < 0.3) {
        
        float w = random(BARRIER_W, width - BARRIER_W - x);
        w -= w % BARRIER_W;

        blocks.add(new Obstacle(x, y, w, BARRIER_H));
        x += w + BARRIER_W;
      } else {
        x += BARRIER_W;
      }
      
      if (random(1) < 0.01) {
        Man m = new Man(x, y - 10, 5, 10);
        men.add(m);
      }
      
    }
  }

  //for (int i = 0; i < 100; i += 1) {
  //  float x = random(BARRIER_W, width - BARRIER_W);
  //  x -= x % BARRIER_W;
  //  float y = random(BARRIER_H, height - BARRIER_H);
  //  y -= y % BARRIER_H;
  //  blocks.add(new Obstacle(x,y,BARRIER_W, BARRIER_H));
  //}
  
}

void draw() {
  background(0);
  for (Obstacle o : blocks) {
    o.draw();
  }

  for (Man m : men) {
    m.applyForce(GRAVITY);
    //m.applyForce(PVector.random2D());
    m.update();
    m.draw();
    m.randomMove();
  }
}

void mouseClicked() {
  MOUSE.set(mouseX, mouseY);
  men.get(0).shootAt(MOUSE);
}