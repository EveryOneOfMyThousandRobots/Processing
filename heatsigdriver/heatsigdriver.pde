void setup () {
  size(600, 600);
  ship = new Ship();
}

void draw() {
  background(0);
  pushMatrix();
  drawStars();
  translate(width / 2, height / 2);

  ship.update();
  ship.draw();
  popMatrix();
}

void drawStars() {
  loadPixels();
  float zoff = 1;
  for (float x = 0; x < width; x += 1) {
    for (float y = 0; y < height; y += 1) {
      float xoff = (x + ship.pos.x) * (0.006);
      float yoff = (y + ship.pos.y) * (0.006);

      float n1 = noise(xoff, yoff, 0);
      float n2 = n1 * 0.8;
      float n3 = n1 * 0.5;
      float r = map(n1, 0, 1, 0, 128);
      float g = map(n2, 0, 1, 0, 128);
      float b = map(n3, 0, 1, 0, 64);
      int i = floor(x) + floor(y) * width;
      pixels[i] = color(r,g,b);
      
    }
  }
  //for (float zoff = -1; zoff < 0; zoff += 0.2) {

  //}
  updatePixels();
}

void mousePressed() {
}

void mouseDragged() {
  MOUSE.set(mouseX -(width/2), mouseY - (height/ 2));
  ship.applyForce(MOUSE.normalize());
  
}