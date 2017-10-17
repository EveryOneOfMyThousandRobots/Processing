class CMover extends C {
  boolean lock =false;
  PVector target;
  CMover (PVector pos, PVector size, PVector angle, PVector target) {
    super(pos, size, angle);
    this.target = target.copy();
    PVector tf = PVector.sub(target, pos);
    PVector ttf = new PVector(-tf.y, tf.x, -tf.z);
    ttf.normalize();
    ttf.mult(10);
    applyForce(ttf);
    
  }
  
  
  void move () {
    
    if (PVector.dist(pos, target) <= 3) {
     lock = true;
     pos = target.copy();
     vel.mult(0);
     accel.mult(0);
    } 
    
    PVector tf = PVector.sub(target, pos);
    tf.normalize();
    tf.mult(1 / tf.magSq());
    applyForce(tf);
    //PVector force = PVector.sub(target, pos);
    //force.normalize();
    //force.mult(0.1);
    //this.applyForce(force);
  }
  
  void applyForce(PVector force) {
    if (!lock) {
      super.applyForce(force);
    }
  }
  
  
  
  
}