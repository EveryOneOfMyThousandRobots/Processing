float dist = 0;
float min_dist, mid_dist, max_dist;

void setup() {
  size(400,400);
  min_dist = 50;
  mid_dist = width / 2;
  max_dist = width;
  noLoop();
}


void draw() {
  background(0);
  for (int x = 1; x < width; x += 5) {
    dist = x;
    float y = height / 2;
    float n = 0;
    if (dist < min_dist) {
      n = (dist / min_dist);
      y = map(n, 0, 1.0, 0, height/2);
      println("min " + x + "="+y + " " + n);
    } else if (dist < mid_dist) {
      y = map(dist, min_dist, mid_dist, height / 2, 0);
      println("mid " + x + "="+y);
    } else if (dist < max_dist) {
      n = (dist - mid_dist) / (max_dist - mid_dist);
      y = map(n, 0, 1, 0, height/2);
      println("max " + x + "="+y + " " + n);
    }
    stroke(255);
    point(x,y);
    //println(x + " " + y);
    

  }
}
