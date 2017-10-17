PImage original;

void settings() {
  original = loadImage("mona.jpg");
  size(original.width * 2, original.height + 150, P2D);
  
}
Population population;
void setup() {
  population = new Population(20);
}



void draw() {
  background(0);
  
  image(original, 0,0);
  loadPixels();
  //Chunk chunk = new Chunk(0,0,20,20,original.width, 0);
  chunk.attempt();
  chunk.check();
  fill(255);
  text(chunk.fitness, 10, original.height+10);
  chunk.mutate();
  updatePixels();
  //noLoop();
  
}