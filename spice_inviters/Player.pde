final int MOVE_FORWARD = 1;
final int MOVE_BACK = -1;

class Player {
  MovingEntity entity;
  Sprite sprite;
  float rotateInc = radians(5);
  boolean thrusting = false;
  float rotating = 0;
  int shotCooldown = 0;
  final int id = ids.getNextId("player");
  
  int hashCode() {
    return id * 31;
  }

  Player(float x, float y) {
    entity = new MovingEntity(x, y, 20, 20, 0.01, 5, 1, false);

    entity.sprite.addVertex(0, -10);
    entity.sprite.addVertex(-10, 10);
    entity.sprite.addVertex(10, 10);
    sprite = entity.sprite;
  }

  void update() {
    if (thrusting) {
      thrust();
    }
    rotate(rotating);
    entity.update();
    if (shotCooldown > 0) {
      shotCooldown -= 1;
    }
  }

  void draw() {
    sprite.draw();
  }

  void rotate(float a) {
    entity.rotate(a * rotateInc);
  }

  void thrust() {
    PVector vel = PVector.fromAngle(entity.r-HALF_PI);
    //vel.normalize();
    entity.mover.applyForce(vel);
  }
  
  void shoot() {
    if (shotCooldown == 0) {
      shotCooldown = 10;
      addShot(entity.mover.pos.x,entity.mover.pos.y,entity.r-HALF_PI, 5, entity.mover.vel);
    }
    
  }
}
