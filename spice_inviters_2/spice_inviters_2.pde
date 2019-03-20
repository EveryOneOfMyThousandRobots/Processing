
void settings() {
  size(WIN_WIDTH, WIN_HEIGHT);
}
void setup() {
  player = new Player(PLAYER_START_XPOS, PLAYER_START_YPOS);
  entities.add(player);
  PFont f = createFont("Fixedsys Regular", 10);
  textFont(f);
}

void draw() {
  background(0);

  long timeNow = System.nanoTime();
  delta = (timeNow - lastTime) / 1000000;
  fDelta = delta;
  lastTime = timeNow;
  fps = 1000 / delta;

  updateDebug();

  if (!paused) {

    entityLoop();
    explosionLoop();

    checkCollisions();
    multiplier = lerp(multiplier, 1, multiplerFactor);
    if (player.collided) {
      player.reset();
    }
    
  } else {
    text("PAUSED\nPRESS SPACE TO START", PLAYER_START_XPOS, PLAYER_START_YPOS);
  }
  drawHUD();
}

void explosionLoop() {
  for (int i = explosions.size() - 1; i >= 0; i -= 1) {
    Explosion e = explosions.get(i);
    e.update();
    e.draw();
    if (e.finished) {
      explosions.remove(i);
    }
  }
}

void checkCollisions() {
  removeMe.clear();
  for (Entity e : entities) {
    if (e instanceof Rock || e instanceof Missile) {
      if (player.iFrames == 0 && player.collides(e)) {
        player.collided = true;
        if (e instanceof Rock) {
          breakRock((Rock)e);
        } else if (e instanceof Missile) {
          removeMe.add(e);
          createExplosion(e.mover.pos.x,e.mover.pos.y,100);
        }
        break;
      }
    }
  }
  removeDeleted();
  
  for (int i = entities.size()-1; i >= 0; i -= 1) {
    Entity e = entities.get(i);

    if (e instanceof Missile) {
      Missile m = (Missile) e;
      for (int j = entities.size()-1; j >= 0; j -= 1) {
        if (i == j) continue;
        Entity ej = entities.get(j);
        if (ej instanceof Rock) {
          Rock r = (Rock) ej;
          if (m.collides(r)) {
            removeMe.add(e);
            breakRock(r);
            //removeMe.add(ej);
            //createExplosion(e.mover.pos.x, e.mover.pos.y, 100);
            //makeFragments(e.mover.pos.x, e.mover.pos.y, r.rad);
          }
        }
      }
    } else if (e instanceof Shot) {
      Shot s = (Shot) e;
      for (int j = entities.size()-1; j >= 0; j -= 1) {
        if (i == j) continue;
        Entity f = entities.get(j);
        if (f instanceof Rock) {
          Rock r = (Rock) f;

          if (s.collides(r)) {

            //float radius = r.rad;
            //float x = r.mover.pos.x;
            //float y = r.mover.pos.y;
            removeMe.add(e);
            breakRock(r);
            //removeMe.add(f);
            //createExplosion(x, y, 100);

            //makeFragments(x, y, radius);
            addScore(f.scoreValue);
          }
        } else if (f instanceof Missile) {
          Missile m = (Missile) f;
          if (s.collides(m)) {
            removeMe.add(e);
            removeMe.add(f);
            createExplosion(f.mover.pos.x, f.mover.pos.y, 50);
            addScore(f.scoreValue);
          }
        }
      }
    }
  }
  removeDeleted();

}


void entityLoop() {
  rockCount = 0;
  enemyCount = 0;
  for (int i = entities.size() - 1; i >= 0; i -= 1) {
    Entity e = entities.get(i);
    if (e instanceof Player) {
      //player.update();
      //player.draw();
      ((Player)e).update();
      ((Player)e).draw();
    } else if (e instanceof Shot) {
      ((Shot)e).update();
      ((Shot)e).draw();
      if (e.wentOffScreen) {
        entities.remove(i);
      }
    } else if (e instanceof Rock) {
      ((Rock)e).update();
      ((Rock)e).draw();
      rockCount += 1;
    } else if ( e instanceof Missile) {
      ((Missile)e).update();
      ((Missile)e).draw();
      enemyCount += 1;
    }
  }

  if (rockCount < 5 && random(1) < 0.01) {
    entities.add(new Rock());
  }

  if (enemyCount < 2 && random(1) < 0.01) {
    entities.add(new Missile());
  }
}


void drawHUD() {
  fill(0);
  stroke(255);
  rect(0, 0, WIN_WIDTH, PLAY_YPOS);
  fill(255);
  if (debug) {
    
    text("delta: " + displayDelta + "\nfps: " + displayFPS + "\nk: " + kp + "\nfr: " + frameRate, 10, 10);
  }

  text("score : " + score + "\nHigh Score : " + highScore + "\nMult: " + multiplier, width / 2, 10);
}

void updateDebug() {
  lastUpdateDebug += delta;
  if (lastUpdateDebug >= 1000) {
    lastUpdateDebug = 0;
    displayDelta = delta;
    displayFPS = fps;
  }
}
