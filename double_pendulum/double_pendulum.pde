float r1;// = 100;
float r2;// = 100;
float m1 = 50;
float m2 = 50;

float a1,a2;
float a1_v, a2_v;
float a1_a, a2_a;
float g = 1;

PGraphics canvas;

void setup(){
  size(600,600);
  r1 = height / 4;
  r2 = height / 4;
  a1 = -PI;
  a2 = -PI + 0.01;
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  //a1_a = 0.01;
  //a2_a = -0.02;
}

void draw() {
  //canvas
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2 * a2);
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = pow(a2_v,2) * r2 + pow(a1_v,2) * r1 * cos(a1 - a2);
  
  float den1 = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2)); 
  a1_a = (num1 + num2 + num3 * num4) / den1;
  
  num1 = 2 * sin(a1 - a2);
  num2 = pow(a1_v, 2) * r1 * (m1 + m2);
  num3 = g * (m1 + m2) * cos(a1);
  num4 = pow(a2_v,2) * r2 * m2 * cos(a1 - a2);
  den1 = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  
  
  
  a2_a = (num1 * (num2 + num3 + num4)) / den1;
  //main loop
  //background(255);
  image(canvas,0,0);
  stroke(0);
  strokeWeight(2);
  fill(0);
  
  translate(width / 2, height / 6);
  
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  
  line(0,0,x1,y1);
  ellipse(x1, y1, 10, 10);
  
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  
  line(x1,y1,x2,y2);
  ellipse(x2,y2, 10,10);
  
  a1 += a1_v;
  a2 += a2_v;
  a1_v += a1_a;
  a2_v += a2_a;
  a1_v *= 0.98;
  a2_v *= 0.98;
  a1_a = 0;
  a2_a = 0;
  
  canvas.beginDraw();
  canvas.translate(width / 2, height / 6);
  canvas.stroke(0);
  canvas.strokeWeight(2);
  //canvas.point(x1, y1);
  canvas.point(x2,y2);
  canvas.endDraw();
  
}