final float WINDOW_WIDTH = 1280;
final float WINDOW_HEIGHT = 720;
final float MARGIN = 30;
final float SLIDER_HEIGHT = 50;
final color BACKGROUND_COLOUR = color(255);
final color BORDER_COLOUR = color(0,255,255);
final int FRAME_RATE = 60;

void settings() {
  size((int)WINDOW_WIDTH, (int)WINDOW_HEIGHT);
}

void setup() {
  frameRate(FRAME_RATE);
  noStroke();
}

void draw() {
  background(BACKGROUND_COLOUR);
  
  fill(BORDER_COLOUR);
  
  //draw border
  rect(0,0,MARGIN, WINDOW_HEIGHT);
  rect(WINDOW_WIDTH - MARGIN, 0, MARGIN, WINDOW_HEIGHT);
  rect(0,0, WINDOW_WIDTH, MARGIN);
  rect(0, WINDOW_HEIGHT - MARGIN, WINDOW_WIDTH, MARGIN);
  
  rect(0, WINDOW_HEIGHT - (MARGIN * 3), WINDOW_WIDTH, MARGIN);
  
  
}