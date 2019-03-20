StartPos getRandomOffScreenPos () {
  StartPos s = new StartPos();
  float x=0, y=0;
  float xv=0, yv=0;
  int r = floor(random(4))+1;
  switch (r) {
  case 1: //top
    x = random(PLAY_XPOS - PLAY_OFFSCREEN, PLAY_XPOS + PLAY_WIDTH + PLAY_OFFSCREEN);
    y = PLAY_YPOS - (PLAY_OFFSCREEN / 2);
    xv = random(-1, 1);
    yv = random(0.1, 1);
    break;
  case 2: //bottom
    x = random(PLAY_XPOS - PLAY_OFFSCREEN, PLAY_XPOS + PLAY_WIDTH + PLAY_OFFSCREEN);
    y = PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2);
    xv = random(-1, 1);
    yv = random(-0.1, -1);      
    break;
  case 3: //left
    x = PLAY_XPOS - (PLAY_OFFSCREEN / 2);
    y = random(PLAY_YPOS - PLAY_OFFSCREEN, PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2));
    xv = random(0.1, 1);
    yv = random(-1, 1);      
    break;
  case 4: //right
    x = PLAY_XPOS + PLAY_WIDTH +  (PLAY_OFFSCREEN / 2);
    y = random(PLAY_YPOS - PLAY_OFFSCREEN, PLAY_YPOS + PLAY_HEIGHT + (PLAY_OFFSCREEN / 2));
    xv = random(-0.1, -1);
    yv = random(-1, 1);      
    break;
  }

  s.pos.set(x, y);
  s.vel.set(xv, yv);
  s.vel.normalize();
  return s;
}

class StartPos {
  PVector pos, vel;
  StartPos() {
    pos = new PVector();
    vel = new PVector();
  }
}

void makeFragments(float x, float y, float r) {
  int n = floor(random(2, 5));
  if (r/n < 8) return;
  for (int i = 0; i < n; i += 1 ) {
    entities.add(new Rock(x, y, r / n));
  }
}


void addScore(int v) {
  multiplier += 1;
  score += floor(float(v) * floor(multiplier));
  if (score > highScore) {
    highScore = score;
  }
}

void removeShots() {
  for (int i = entities.size()-1; i >= 0; i -= 1) {
    if (entities.get(i) instanceof Shot) {
      entities.remove(i);
    }
  }
}


void breakRock(Rock r) {
  removeMe.add(r);
  makeFragments(r.mover.pos.x, r.mover.pos.y, r.rad);
  createExplosion(r.mover.pos.x, r.mover.pos.y, 100);
}

void removeDeleted() {
  for (Entity r : removeMe) {
    entities.remove(r);
  }
  removeMe.clear();
}
