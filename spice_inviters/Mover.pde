class Mover {
  PVector pos, vel, acc, dims;
  final float drag;
  final float maxSpeed;
  final float maxForce;
  float direction;
  Collider collider;
  final int id = ids.getNextId("mover");
  int hashCode() {
    return id * 3;
  }
  
  
  Mover(float x, float y, float w, float h, float drag, float maxSpeed, float maxForce) {
    this.drag = drag;
    this.maxSpeed = maxSpeed;
    this.maxForce = maxForce;
    pos = new PVector(x,y);
    vel = new PVector();
    acc = new PVector();
    collider = new Collider(x,y,w,h);
    dims = new PVector(w,h);
  }
  
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    
    vel.limit(maxSpeed);
    vel.mult(1 - drag);
    pos.add(vel);
    direction = vel.heading();// + HALF_PI;
    collider.setPos(pos.x, pos.y);
    
    
  }
  
  void setPos(float x, float y) {
    pos.set(x,y);
    collider.setPos(x,y);
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void draw() {
    collider.draw();
    
  }
  
  
}
