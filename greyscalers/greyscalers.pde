int POP_SIZE = 30;
PImage testImage;
float sbx, sby, sbw, sbh;
Pop pop;

ArrayList<Float> graph = new ArrayList<Float>();

void setup() {
  //size(400,400);
  colorMode(HSB);
  pop = new Pop(POP_SIZE);
  frameRate(10000);
  textFont(createFont("Consolas", 11));

}


void settings() {
  testImage = loadImage("mona.png");
  size(testImage.width * 2, testImage.height * 2);
  sbx = testImage.width;
  sby = 0;
  sbw = testImage.width;
  sbh = testImage.height;
  
  
}
void draw() {
  background(0);
  image(testImage, 0,0);
  testImage.loadPixels();
  pop.cycle();
  fill(255);
  text(pop.toString(), 10, sbh+10);
  
  if (graph.size() > width) {
    graph.remove(0);
  }
  float highest = 0;
  for (float f : graph) {
    if (f > highest) {
      highest = f;
    }
  }
  
  float step = float(width) / float(graph.size()+1);
  float colourStep = 255.0/ float(graph.size()+1);
  for (int i = 0; i < graph.size(); i += 1) {
    stroke(colourStep * i, 255,255);
    float f = graph.get(i);
    float y = map(f, 0, highest, height, height - (height / 4));
    point(step * i, y);
    
  }


  
}