ArrayList<PGraphics> images;

void setup() {
  String[] fileNames = listFileNames(sketchPath()+"\\data");
  images = new ArrayList<PGraphics>();
  for (String fname : fileNames) {
    println(fname);
    PImage img = loadImage(fname);
    PGraphics g = createGraphics(60, 60);
    PVector dims = mResize(img,g.width,g.height);
    img.resize(floor(dims.x),floor(dims.y));
    
    g.beginDraw();
    //g.background(255);
    g.image(img,(g.width/2)-(img.width/2),(g.height/2)-(img.height/2));
    g.endDraw();
    images.add(g);
  }
  
  size(300,300);
  noLoop();
  
}

PVector mResize(PImage img, float maxWidth, float maxHeight) {


  PVector newDims = new PVector(img.width, img.height);
  float imgW = img.width;
  float imgH = img.height;
  if (imgW > maxWidth) {
    float ratio = maxWidth / imgW;
    newDims.x = round(imgW*ratio);
    newDims.y = round(imgH*ratio);
    if (newDims.y > maxHeight) {
      ratio = maxHeight/newDims.y;
      newDims.x = round(newDims.x*ratio);
      newDims.y = round(newDims.y*ratio);
      
    } 
  } else if (imgH > maxHeight) {
    float ratio = maxHeight/imgH;
    newDims.x = round(imgW*ratio);
    newDims.y = round(imgH*ratio);
    if (newDims.x > maxWidth) {
      ratio = maxWidth / newDims.x;
      newDims.x = round(newDims.x*ratio);
      newDims.y = round(newDims.y*ratio);
    }
  }

  return newDims;
}

void draw() {
  int x = 0;
  int y = 0;
  background(0);
  for(PGraphics p : images) {
    print(" " + p.width);
    image(p,x,y);
    stroke(255);
    noFill();
    rect(x,y,p.width,p.height);
    x += p.width;
    if (x >= width) {
      x = 0;
      y += p.height;
      if (y > height) {
        y = 0;
      }
    }
    
  }
  
}


String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
