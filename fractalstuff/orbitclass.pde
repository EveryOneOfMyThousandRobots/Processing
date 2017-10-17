
class Orbit {
  Orbit parent = null;
  Orbit child = null;

  float x, y;
  float radius;
  float diameter;
  float angle;
  float angle_inc;
  int level;


  Orbit(float x, float y, float r, int level) {
    this(x, y, r, level, null);
  }
  Orbit(float x, float y, float r, int level, Orbit parent) {
    this.x = x;
    this.y = y;
    this.angle = -PI/2;
    this.angle_inc = (radians(pow(k, level-1)))/res;
    this.parent = parent;
    this.radius = r;
    this.diameter = radius * 2;
    this.level = level;// + 1;
  }

  Orbit addChild() {
    if (child == null) {
      float child_r = radius / 3;
      float child_x = x + radius + child_r;
      float child_y = y;
      //float child_speed = (angle_inc * (1+(1/12))) * -3;
      child = new Orbit(child_x, child_y, child_r, level+1, this);
      return child;
    } else {
      return child.addChild();
    }
  }



  void update() {

    if (parent != null) {
      angle += angle_inc;
      x = parent.x + (radius + parent.radius) * cos(angle);
      y = parent.y + (radius + parent.radius) * sin(angle);
    }
    if (child != null) {
      child.update();
    }
  }

  void draw() {
    noFill();
    stroke(255);
    strokeWeight(1);
    if (draw_circles) {
      ellipse(x, y, diameter, diameter);
    }
    if (child != null) {
      child.draw();
    } else {
      
      path.add(new PVector(x, y));
      if (path.size() > 10000) {
        
        path.remove(0);
      }
    }
  }
}