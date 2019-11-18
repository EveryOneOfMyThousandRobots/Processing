PGraphics post;


ArrayList<S> shapes = new ArrayList<S>();


void setup() {
  size(300, 300, P3D);
  PVector rot = new PVector(0.01,0.01,0);
  for (int x = width / 4; x < width; x += width / 4) {
    for (int y = height / 4; y < height; y += height / 4) {
      S s = new S(x,y, -50);
      
      s.applyRotForce(rot);
      shapes.add(s);
      println(s.pos.z);
    }
  }
  
  post = createGraphics(width, height);
  ma = new float[SIZE][SIZE];
  float n = 1.0 / 16.0;
  for (int x = 0; x < SIZE; x += 1) {
    for (int y = 0; y < SIZE; y += 1) {
      m[x][y] = floor(random(1,16));
      ma[x][y] = m[x][y] * n;
    }
  }
  //noLoop();
}


void draw() {

  background(255);
  
  ambientLight(128,128,128);
  directionalLight(255,255,0,1,0,0);
  directionalLight(255,0,255,0,1,0);
  directionalLight(40,40,40,0,0,-1);
  for (S s : shapes) {
    s.update();
    s.draw();
  }
  loadPixels();

  process();
  image(post, 0, 0);
}
