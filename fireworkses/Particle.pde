class Particle extends Mover {
  color col;
  int lifeTime;
  int frames = 0;
  Particle(float x, float y, float xv, float yv, color c) {
    super(x,y,xv,yv);
    col = c;
    lifeTime = floor(random(200,500));
  }
  
  void draw() {
    stroke(col);
    point(pos.x, pos.y);
    trails.beginDraw();
    trails.stroke(col);
    trails.point(pos.x, pos.y);
    trails.endDraw();
  }
  
  void update() {
    super.update();
    frames += 1;
    if (frames > lifeTime) {
      alive = false;
    }
  }
}
