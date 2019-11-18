PGraphics img;
void setup() {
  size(300,300);
  noLoop();
  img = createGraphics(width,height);
}


void draw() {
  saveFrame("out/a.png");
  background(0);
  saveFrame("out/b.png");
  ellipse(width/2,height/2,10,10);
  saveFrame("out/c.png");
  
  img.beginDraw();
  img.background(51);
  saveFrame("out/d.png");
  
  img.stroke(255);
  img.noFill();
  img.ellipse(img.width/3,img.width/2,20,20);
  
  img.endDraw();
  saveFrame("out/e.png");
  image(img,0,0);
  saveFrame("out/f.png");
  img = doSomething(img);
  image(img,0,0);
  saveFrame("out/g.png");
}

PGraphics doSomething(PGraphics input) {
  PGraphics nm = createGraphics(input.width,input.height);
  
  input.beginDraw();
  input.loadPixels();
  nm.beginDraw();
  nm.loadPixels();
  for (int i = 0; i < input.pixels.length; i += 1) {
    nm.pixels[i] = input.pixels[i];
  }
  nm.updatePixels();
  
  nm.endDraw();
  
  input.endDraw();
  
  return nm;
  
}
