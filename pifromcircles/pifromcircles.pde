float x, y;
float r, d;
PVector c;
PVector p;

float total = 0;
float inside = 0;

float estimate = 0;

void setup() {
  size(400, 400);
  x = width / 2;
  y = height/ 2;
  r = width / 2;
  d = r * 2;
  background(0);
  noFill();
  stroke(255);
  ellipse(x, y, d, d);
  c = new PVector(x, y);
  p = new PVector(0, 0);
}

void draw() {
  p.x = random(width);
  p.y = random(height);


  float dist = PVector.dist(c, p);
  total += 1;
  if (dist < r) {
    inside += 1;
  }
  point(p.x, p.y);

  estimate = 4 * (inside / total);
  if (frameCount % 100 == 0) {
    //fill(0);
    //noStroke();
    //rect(0, y - 50, width, 100);
    //fill(255);
    //stroke(255);
    ////text(estimate * 4, x, y);
    //text("(" + inside + " / " + total + ") * 4 = " + (estimate * 4), x,y);
    println("(" + inside + " / " + total + ") * 4 = " + (estimate) + " error: " + nfc(abs(100 - ((estimate / PI) * 100)), 2) + "%");
    //println((estimate / PI));
    
    
  }
  
  if (nfc(estimate * 4, 5) == "3.14159") {
    println("----------DONE!----------");
    stop();
  }
}