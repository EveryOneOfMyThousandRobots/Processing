ArrayList<Snowflake> flakes = new ArrayList<Snowflake>();

void setup() {
  size(400, 400);
  for (int i = 0; i < 10; i += 1) {
    float x = random(width);
    float y = random(height);
    float angleStep = TWO_PI / floor(random(4,10));
    float lengthFactor = random(0.1, 0.7);
    float size = random(10,100);
    float branchAngle = random(0.1, PI / 4);
    Snowflake s  = new Snowflake(x,y,angleStep,lengthFactor,size,branchAngle);
    s.generate();
    flakes.add(s);
  }

  noLoop();
}


void draw() {
  //println("hello");
  background(0);
  for (Snowflake s : flakes) {
    s.draw();
  }
}
