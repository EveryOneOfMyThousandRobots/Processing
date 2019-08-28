class Rock extends Entity {

  //MovingEntity entity;
  float rv;
  float rad = ROCK_START_SIZE;
  final int id = ids.getNextId("rock");

  Rock(float x, float y, float r) {
    super(x, y);
    rad= r;
    makeSprite();
    mover.setPos(x, y);


    setFacingIsRotation(true);
    mover.setDrag(0);
    mover.setMaxSpeed(4);
    mover.applyForce(PVector.random2D().setMag(random(1, 4)));
  }

  void makeSprite() {
    float segments = floor(random(5, 12));
    float ai = TWO_PI / segments;
    //float rad = 20;
    for (float a = 0; a < TWO_PI; a += ai) {
      float rr = rad + random(-5, 5);
      float aa = a + radians(random(-5, 5));
      float xx =  rr * cos(aa);
      float yy =  rr * sin(aa);
      sprite.addVertex(xx, yy);
    }
    finishedSprite();
  }

  Rock () {
    //super(0,0);
    super(0, 0);
    float x = 0;
    float y = 0;

    float xv = 0;
    float yv = 0;
    rv = radians(random(-3, 3));
    //int r = floor(random(4))+1;
    //switch (r) {
    //case 1: //top
    //  x = random(PLAY_XPOS - PLAY_OFFSCREEN, PLAY_XPOS + PLAY_WIDTH + PLAY_OFFSCREEN);
    //  y = PLAY_YPOS - (PLAY_OFFSCREEN / 2);
    //  xv = random(-5, 5);
    //  yv = random(1, 5);
    //  break;
    //case 2: //bottom
    //  x = random(PLAY_XPOS - PLAY_OFFSCREEN, PLAY_XPOS + PLAY_WIDTH + PLAY_OFFSCREEN);
    //  y = PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2);
    //  xv = random(-5, 5);
    //  yv = random(-1, -5);      
    //  break;
    //case 3: //left
    //  x = PLAY_XPOS - (PLAY_OFFSCREEN / 2);
    //  y = random(PLAY_YPOS - PLAY_OFFSCREEN, PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2));
    //  xv = random(1, 5);
    //  yv = random(-5, 5);      
    //  break;
    //case 4: //right
    //  x = PLAY_XPOS + PLAY_WIDTH +  (PLAY_OFFSCREEN / 2);
    //  y = random(PLAY_YPOS - PLAY_OFFSCREEN, PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2));
    //  xv = random(-1, -5);
    //  yv = random(-5, 5);      
    //  break;
    //}
    //entity = (float x, float y, float w, float h, float drag, float maxSpeed, float maxForce, boolean facingIsRotation)
    //entity = new MovingEntity(x, y, 20, 20, 0.0, 5, 1, true);
    StartPos s = getRandomOffScreenPos();
    x = s.pos.x;
    y = s.pos.y;
    s.vel.mult(random(1,5));
    xv = s.vel.x;
    yv = s.vel.y;
    makeSprite();
    //float segments = floor(random(5, 12));
    //float ai = TWO_PI / segments;
    ////float rad = 20;
    //for (float a = 0; a < TWO_PI; a += ai) {
    //  float rr = rad + random(-5, 5);
    //  float aa = a + radians(random(-5, 5));
    //  float xx =  rr * cos(aa);
    //  float yy =  rr * sin(aa);
    //  sprite.addVertex(xx, yy);
    //}
    //finishedSprite();
    mover.setPos(x, y);

    setFacingIsRotation(true);
    mover.setDrag(0);
    mover.setMaxSpeed(4);
    mover.applyForce(new PVector(xv, yv));
  }

  void update() {
    super.update();
    super.rotate(rv);
  }

  //void draw () {
  //  entity.draw();
  //  fill(255);
  //  text(id, entity.mover.pos.x, entity.mover.pos.y);
  //}
}
