PGraphics sheet1, sheet2;
int tSize = 5;
int tStep = 2;
PGraphics generateSheet() {
  PGraphics img = createGraphics(width, height);
  img.beginDraw();
  
  for (int x = -tSize; x < img.width+tSize; x += tSize) {
    
    //boolean xm = x % 2 == 0;
    for (int y = -tSize; y < img.height+tSize; y += tSize) {
      img.stroke(0);
      img.fill(0);
      img.beginShape();
      img.vertex(x,y);
      img.vertex(x + tStep,y + tSize);
      img.vertex(x - tStep,y + tSize);
      img.endShape(CLOSE);


//random
      //if (random(1) < 0.1) {
      //  img.pixels[y * img.width + x] = color(0);
      //} else {
      //  img.pixels[y * img.width + x] = color(0, 0, 0, 0);
      //}
      
      
      //if ((xm && ym) || (!xm && !ym)) {
      //  img.pixels[y * img.width + x] = color(0); 
      //} else {
      //  img.pixels[y * img.width + x] = color(0,0,0,0);
      //}
    }
  }

  
  img.endDraw();
  return img;
}

PGraphics copyGraphics(PGraphics img) {
  PGraphics imgNew = createGraphics(img.width, img.height);
  img.beginDraw();
  imgNew.beginDraw();
  img.loadPixels();
  imgNew.loadPixels();
  
  for (int i = 0; i < img.pixels.length; i += 1) {
    imgNew.pixels[i] = img.pixels[i];

  }
  imgNew.updatePixels();
  img.endDraw();
  imgNew.endDraw();
  return imgNew;
}


void setup() {

  size(600, 600);
  sheet1 = generateSheet();
  
  
  sheet2 = copyGraphics(sheet1);
    
}

float angle = 0;
float angle2 = 0;
void draw() {
  angle += radians(0.1);
  angle2 += radians(0.3);
  background(255);

  image(sheet1, 0, 0);
  translate(width / 2, (height / 2) + ((height / 8) *sin(angle2)));
  rotate(angle);
  image(sheet2, -width/2, -height/2);
}
