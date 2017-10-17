final float ANGLE_FROM = -radians(5);
final float ANGLE_TO = radians(5);

class Job {
  PVector dir;
  int time;

  Job () {
    dir = PVector.random2D();
    time = floor(random(25));
  }

  Job(Job copyMe) {
    float angle = copyMe.dir.heading();
    time = copyMe.time;
    if (random(1) < 0.01) {
      angle += random(ANGLE_FROM, ANGLE_TO);
      time += pom1();
    }
    dir = PVector.fromAngle(angle);
    
    
    
  }

  String toString() {
    return "Job " + dir.toString() + " t(" + time + ")";
  }
}