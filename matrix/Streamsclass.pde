class Stream {
  ArrayList<Chr> chars = new ArrayList<Chr>();
  PVector pos;
  float speed;
  float h;
  Stream (float x, float y) {
    pos = new PVector(x,y);
    speed = random(2,7);
    int count = floor(random(5,30));
    for (int i = 0; i < count; i += 1) {
      chars.add(new Chr());
    }
    h = count * textSize;
  }
  
  void update() {
    pos.y += speed;
    if (pos.y > height + h) {
      pos.y = 0;
    }
    
    for (Chr c : chars) {
      c.update();
    }
       
  }
  
  void draw() {
    for(int i = 0; i < chars.size(); i += 1) {
      Chr c = chars.get(i);
      
      c.draw(pos.x,pos.y - (textSize * i));
    }
  }
  
  
}