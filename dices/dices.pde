class Die {
  int value;
  PVector pos, dim;

  Die(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dim = new PVector(w, h);

    value = (int)random(1, 6);
  }

  void draw() {
    stroke(0);
    noFill();
    rect(pos.x, pos.y, dim.x, dim.y);
    float cx = pos.x + (dim.x / 2);
    float cy = pos.y + (dim.y / 2);
    
    float x3 = pos.x + (dim.x / 3);
    float y3 = pos.y + (dim.y / 3);
    switch (value) {
    case 2:
      ellipse(x3, cy, 2 , 2);
      ellipse(x3 * 2, cy, 2, 2);
      break;
    case 3:
      ellipse(cx, cy, 2, 2);
      ellipse(x3, y3 * 2, 2, 2);
      ellipse(x3 * 2, y3, 2, 2); 
      break;
    case 1:
      ellipse(cx, cy, 2, 2);
    case 4:
    
    case 5:
      
      ellipse(x3, y3, 2, 2);
      ellipse(x3 * 2, y3, 2, 2);
      ellipse(x3, y3 * 2, 2, 2);
      ellipse(x3 * 2, y3 * 2, 2, 2);
      
      break;
    }
  }
}


ArrayList<Die> dice = new ArrayList<Die>();
void setup()  {
  for (int i = 0; i < 2; i += 1) {
    for (int j  = 0; j < 2; j += 1) {
      float x = (width / 3) + ((width / 3) * i);
      float y = (height / 3) + ((height / 3) * j);
      Die d = new Die(x,y,20,20);
      dice.add(d);
    }
  }
}

void draw() {
}