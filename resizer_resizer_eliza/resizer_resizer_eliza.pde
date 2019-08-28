ArrayList<PGraphics> srcImages;
ArrayList<PGraphics> dstImages;
float timeNow = 0;
float timeLast = 0;
float timeDelta = 0;
float timeAccum = 0;
void setup() {
  size(1000,500);
  
  srcImages = new ArrayList<PGraphics>();
  for(int i = 0; i < 5; i += 1) {
    srcImages.add(makeRandomGraphics());
  }
  dstImages = new ArrayList<PGraphics>();
  colorMode(HSB);
  
}

PGraphics makeRandomGraphics() {
  PGraphics img = createGraphics(floor(random(width/8,width/2)), floor(random(height/8,height)));
  img.beginDraw();
  img.colorMode(HSB);
    img.stroke(color(random(255), 255,255));
     img.noFill();
  img.beginShape(TRIANGLES);
  for (int i = 0; i < 21; i += 1) {
    float x1 = random(0, img.width);
    float y1 = random(0,img.height);
    img.vertex(x1,y1);
    

    
    
  }
  img.endShape(CLOSE);
  
  img.noFill();
  img.stroke(255);
  img.strokeWeight(2);
  img.rect(0,0,img.width,img.height);
  img.strokeWeight(1);
  img.endDraw();
  
  return img;
}

int srcImageIndex = 0;
void draw() {
  timeNow = millis();
  timeDelta = timeNow - timeLast;
  timeLast = timeNow;
  timeAccum += timeDelta;
  background(0);
  
  image(srcImages.get(srcImageIndex),0,0);
  if (timeAccum > 1000) {
    srcImageIndex = (srcImageIndex + 1) % srcImages.size();
    timeAccum = 0;
  }
}
