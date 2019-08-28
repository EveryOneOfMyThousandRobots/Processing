class Rock {

  MovingEntity entity;
  float rv;
  final int id = ids.getNextId("rock");

  Rock () {
    float x = 0;
    float y = 0;
    int r = floor(random(4))+1;
    float xv = 0;
    float yv = 0;
    rv = radians(random(-3,3));

    switch (r) {
    case 1: //top
      x = random(ARENA_XPOS - ARENA_OFFSCREEN_SIZE, ARENA_XPOS + ARENA_WIDTH + ARENA_OFFSCREEN_SIZE);
      y = ARENA_YPOS - (ARENA_OFFSCREEN_SIZE / 2);
      xv = random(-5, 5);
      yv = random(1, 5);
      break;
    case 2: //bottom
      x = random(ARENA_XPOS - ARENA_OFFSCREEN_SIZE, ARENA_XPOS + ARENA_WIDTH + ARENA_OFFSCREEN_SIZE);
      y = ARENA_YPOS + ARENA_HEIGHT + (ARENA_OFFSCREEN_SIZE / 2);
      xv = random(-5, 5);
      yv = random(-1, -5);      
      break;
    case 3: //left
      x = ARENA_XPOS - (ARENA_OFFSCREEN_SIZE / 2);
      y = random(ARENA_YPOS - ARENA_OFFSCREEN_SIZE, ARENA_YPOS + ARENA_HEIGHT + (ARENA_OFFSCREEN_SIZE / 2));
      xv = random(1, 5);
      yv = random(-5, 5);      
      break;
    case 4: //right
      x = ARENA_XPOS + ARENA_WIDTH +  (ARENA_OFFSCREEN_SIZE / 2);
      y = random(ARENA_YPOS - ARENA_OFFSCREEN_SIZE, ARENA_YPOS + ARENA_HEIGHT + (ARENA_OFFSCREEN_SIZE / 2));
      xv = random(-1, -5);
      yv = random(-5, 5);      
      break;
    }
    //entity = (float x, float y, float w, float h, float drag, float maxSpeed, float maxForce, boolean facingIsRotation)
    entity = new MovingEntity(x, y, 20, 20, 0.0, 5, 1, true);
    entity.mover.applyForce(new PVector(xv,yv));
    float segments = floor(random(5,12));
    float ai = TWO_PI / segments;
    float rad = 20;
    for (float a = 0; a < TWO_PI; a += ai) {
      float rr = rad + random(-5,5);
      float aa = a + radians(random(-5,5));
      float xx =  rr * cos(aa);
      float yy =  rr * sin(aa);
      entity.sprite.addVertex(xx,yy);
    }
    
    
    
  }
  
  void update() {
    entity.update();
    entity.rotate(rv);
    
  }
  
  void draw () {
    entity.draw();
    fill(255);
    text(id, entity.mover.pos.x, entity.mover.pos.y);
  }
  
  
}
