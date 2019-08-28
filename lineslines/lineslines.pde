float colour_hue = 0;
float row = 0;
float col = 0;

void setup() {
  size(400,400);
  background(0);
  colorMode(HSB);
}

void draw() {
  noStroke();
  fill(0,20);
  rect(0,0,width,height);
  colour_hue += 1;
  colour_hue = colour_hue % 255.0;
  row += 2;
  row = row % height;
  col += 3;
  col = col % width;
  stroke(colour_hue, 255,255, 128);
  line(0,row,width,row);
  line(col,0,col,height);
  
  
}