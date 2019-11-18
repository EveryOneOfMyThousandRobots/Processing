class Map {
  PGraphics img;
  final int across,down;
  final int tileSize;
  Map(int tileSize) {
    
    this.across = width / tileSize;
    this.down = height / tileSize;
    this.tileSize = tileSize;
    
    img = createGraphics(across,down);
    img.beginDraw();
    img.background(0,0);
    //img.noFill();
    //img.stroke(0);
    //img.rect(0,0,img.width-1, img.height-1);
    img.endDraw();
    println("new map (" + across + "," + down + ")");
  }
  
  
  void setByScreenPos(float x, float y) {
    int xp = (int)x / tileSize;
    int yp = (int)y / tileSize;
    
    //println(xp + "," + yp);
    
    img.beginDraw();
    img.stroke(0);
    img.point(xp,yp);
    img.endDraw();
    
    
  }
  
  void draw() {
    image(img,0,0,width,height);
  }
}
