final float FITNESS_EXP =4;
final String MATCH_ME = "To be or not to be that is the question.";
final int MATCH_ME_LEN = MATCH_ME.length();
final float FITNESS_LIMIT = pow(MATCH_ME_LEN, FITNESS_EXP);
float maxFitness = 0;
final float MUTATION_RATE = 0.015;
final int POP_SIZE = 200;
String bestFirstGuess = "";
float bestFirstFitness = 0;

PFont sysFont;

Population pop;
void setup() {
  size(500,500);
  pop = new Population(POP_SIZE);
  sysFont = createFont("Consolas", 12);
  textFont(sysFont);
  frameRate(1000);
  
}

void draw() {
  background(0);
  pop.calc();
  pop.draw();
  if (maxFitness >= FITNESS_LIMIT) {
    stop();
    
  }
  
  pop.breed();
}