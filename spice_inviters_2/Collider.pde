import java.awt.Rectangle;
class Collider {
  final int id = ids.getNextId("Collider");
  Rectangle rect;
  boolean collided = false;
  int hashCode() {
    return id * 101;
  }

  Collider(float x, float y, float w, float h) {
    //rect = new Rectangle(floor(x-(w/2)), floor(y - (h/2)), floor(w), floor(h));
    rect = new Rectangle(floor(x - (w/2)), floor(y - (h/2)), floor(w), floor(h));
  }

  Collider(Rectangle r) {
    this.rect = r;
  }

  void setPos(float x, float y) {
    rect.x = floor(x - (rect.width/2));
    rect.y = floor(y - (rect.height/2));
  }

  void setSize(float w, float h) {
    rect.width = floor(w);
    rect.height = floor(h);
  }


  boolean collides(Collider o) {
    if (o.id == this.id) return false;
    collided =  rect.intersects(o.rect);
    return collided;
  }

  void draw() {
    if (debug) {
      stroke(255, 0, 0);
      noFill();
      rect(rect.x, rect.y, rect.width, rect.height);
    }
  }
}
