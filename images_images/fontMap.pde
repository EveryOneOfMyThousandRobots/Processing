class FontMap {
  ArrayList<Info> images = new ArrayList<Info>();
  int w = 9;
  int h = 9;
  String alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_+=-1234567890()<>,.?/\\#~\';:";

  void make() {
    for (int c = 0; c < alpha.length(); c += 1) {
      Info i = new Info(w,h,str(alpha.charAt(c)));
      images.add(i);
    }
  }
  
  String toString() {
    String out = "";
    for (Info i : images){
      out += i.toString() + "\n";
    }
    
    return out;
  }

  void draw() {
    float x = 0, y = height / 2 + h;
    for (Info p : images) {
      x += w;
      if (x >= width - w || x + w >= width) {
        x = w;
        y += h;
      }
      image(p.g, x, y);
    }
  }
}

class Info {
  PGraphics g;
  int w, h;
  String s;
  float avgBrightness;
  Info(int w, int h, String s) {
    //String s = str(alpha.charAt(c));
    this.w = w;
    this.h = h;
    this.s = s;

    g = createGraphics(w, h);
    g.beginDraw();
    g.background(0);
    //p.noFill();
    //p.stroke(255);
    //p.rect(0,0,w-1,h-1);
    g.fill(255);

    g.textFont(font);
    g.textAlign(CENTER, CENTER);
    g.text(s, g.width/2, g.height/2);
    
    g.loadPixels();
    float b = 0;
    for (color c : g.pixels) {
      b += sqrt(brightness(c));
    }
    b /= g.pixels.length;
    //b /= 255;
    avgBrightness = b;//pow(b,2);
    

    g.endDraw();
  }
  
  String toString() {
    return s + " (" + nfc(avgBrightness, 2) + ")";
  }
  

}
