boolean isPointOOB(float x, float y) {
  return (x < 0 || x > width || y < 0 || y > height);
}

boolean isPointOOB(PVector p) {
  return isPointOOB(p.x, p.y);
}

void addExplosion(PVector pos, PVector vel) {
  expl.add( new Explosion(pos, vel));
}