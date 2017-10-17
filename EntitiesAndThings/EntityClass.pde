abstract class Entity {
  PVector position;
  protected PVector target = null;
  protected float speed = 0;
  
  Entity (PVector position){
    this.position = position.copy();
  }
  
  public void setTarget(PVector target) {
    this.target = target.copy();
    
  }
  
  public void setSpeed(float speed) {
    if (speed < 0) speed = 0;
    if (speed > 1) speed = 1;
    this.speed = speed;
  }
  
  public String toString() {
    String output = "pos(" + position.x + "," + position.y + ")";
    
    if (target != null) {
      output +=  " tar(" + target.x + "," + target.y + ")";
    }
    return  output; 
  }
  
  
  
  abstract void draw();
  abstract void update();
  
  
}