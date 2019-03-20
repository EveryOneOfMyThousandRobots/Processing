
Curve[][] curves;

ArrayList<ParentCircle> parentCols = new ArrayList<ParentCircle>();
ArrayList<ParentCircle> parentRows = new ArrayList<ParentCircle>();
float angle = 0;
float w, r;
float d;
int cols, rows;
void setup() {
  //colorMode(HSB);
  size(800, 800);
  smooth();
  w = width / 6;
  cols = floor(width / w-1);
  rows = floor(width / w-1);
  d = w - 5;
  r = d / 2;
  //edges = new EdgeCircle[cols + rows];


  for (int i = 0; i < cols; i += 1) {
    float cx = w + (w / 2) + (i*w);
    float cy = (w/2);
    float step = (i+1.0);
    ParentCircle e = new ParentCircle(cx, cy, r, step, 0);
    parentCols.add(e);
  }
  for (int j = 0; j < rows; j += 1) {
    float cx = (w/2);
    float cy = w + (w / 2) + (j * w);
    float step = (j+1.0);
    ParentCircle e = new ParentCircle(cx, cy, r, step, 1);
    parentRows.add(e);
  }

  curves = new Curve[cols][rows];

  for (int i = 0; i < cols; i += 1) {
    ParentCircle top = parentCols.get(i);
    int xpos = (int)(top.pos.x - (w/2)); 
    for (int j = 0; j < rows; j += 1) {
      
      ParentCircle left = parentRows.get(j);
      int ypos = (int)(left.pos.y - (w/2));
      Curve c = new Curve(top, left, floor(w), xpos,ypos);
      curves[i][j] = c;
    }
  }
}

void draw() {
  background(0);
  //stroke(255);


  for (int i = 0; i < parentCols.size(); i += 1) {
    ParentCircle pc = parentCols.get(i);
    pc.update();
    pc.draw();
  }
  
  for (int i = 0; i < parentRows.size(); i += 1) {
    ParentCircle pc = parentRows.get(i);
    pc.update();
    pc.draw();
  }
  
  for (int i = 0; i < curves.length; i += 1) {
    for (int j = 0; j < curves[0].length; j += 1) {
      Curve c = curves[i][j];
      c.update();
      c.draw();
    }
  }
  

  ////cols
  //noFill();
  //for (int i = 0; i < cols; i += 1) {
  //  strokeWeight(1);
  //  stroke(255);
  //  float cx = w + (w / 2 ) +(i * w);
  //  float cy = (w/2);
  //  ellipse(cx, cy, d, d);

  //  float x = r * cos((angle * (i +1)) - HALF_PI);
  //  float y = r * sin((angle * (i +1)) - HALF_PI);
  //  strokeWeight(8);
  //  point(cx + x, cy + y);
  //  strokeWeight(1);
  //  stroke(255, 64);
  //  line(cx + x, 0, cx+x, height);
  //}

  ////rows
  //noFill();
  //for (int i = 0; i < cols; i += 1) {
  //  strokeWeight(1);
  //  stroke(255);
  //  float cx = (w/2);
  //  float cy = w + (w / 2) + (i * w);
  //  ellipse(cx, cy, d, d);

  //  float x = r * cos((angle * (i +1)) - HALF_PI);
  //  float y = r * sin((angle * (i +1)) - HALF_PI);
  //  strokeWeight(8);
  //  point(cx + x, cy + y);
  //  strokeWeight(1);
  //  stroke(255, 64);
  //  line(0, cy + y, width, cy + y);
  //}

  //  angle += radians(0.5);
  //  angle = angle % TWO_PI;
}
