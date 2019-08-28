ArrayList<PVector> model = new ArrayList<PVector>();
void Add(float x, float y) {
  model.add(new PVector(x, y));
}

void setup() {
  size(400,400);
  Add( 0.0f, 0.0f);
  Add( 1.0f, 1.0f);
  Add( 2.0f, 1.0f);
  Add( 2.5f, 0.0f);
  Add( 2.0f, -1.0f);
  Add( 1.0f, -1.0f);
  Add( 0.0f, 0.0f);
  Add( -1.0f, -1.0f);
  Add( -2.5f, -1.0f);
  Add( -2.0f, 0.0f);
  Add( -2.5f, 1.0f);
  Add( -1.0f, 1.0f);
}

float x,y, ox, oy;
float angle;
float size = 20;


void draw() {
  background(0);
  angle += radians(1);
  
  x = width / 2;
  y = height / 2;
  ox = 10;
  oy = 20;
  
  for (int i = 0; i < model.size()-1; i += 1) {
    PVector a = model.get(i);
    PVector b = model.get(i+1);
    
    float x1 = size * (a.x * cos(angle) - a.y * sin(angle));
    float y1 = size * (a.x * sin(angle) + a.y * cos(angle));
    float x2 = size * (b.x * cos(angle) - b.y * sin(angle));
    float y2 = size * (b.x * sin(angle) + b.y * cos(angle));
    
    x1 += x - ox;
    x2 += x - ox;
    y1 += y - oy;
    y2 += y - oy;
    stroke(255);
    line(x1,y1,x2,y2);
    
    
    
  }
  
  
}
