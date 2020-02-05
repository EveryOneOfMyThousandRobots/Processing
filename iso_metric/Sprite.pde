class Sprite {
  PImage img;
  
  Sprite(String s) {
    img = loadImage(s);
    img.loadPixels();
  }
  
  
  void draw(float x, float y) {
    image(img, x,y);
  }
  
  color getPix(int x, int y) {
    
    color c = color(0);
    
    c = img.get(x,y);
    
    
    
    return c;
  }
}
