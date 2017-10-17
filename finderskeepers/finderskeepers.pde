
Arena arena;
Population pop;
void setup() {
  pop = new Population(arena, 2);
  textFont(createFont("Consolas", 10));

  frameRate(1000);
}

void settings() {
  arena = new Arena("map4.png", 10);
  size(floor(arena.w), floor(arena.h), P2D);
}
boolean printAll = false;
void draw() {
  background(255);
  printAll = false;
  arena.draw();
  if (pop.generation % 10 == 0 ) {
    printAll = true;
  }
  pop.cycle();

 // if (pop.generation % 2 == 0 ) {
    pop.draw();
  //}


  fill(0);
  text("Age: " + pop.age, 15, 15);
  text("gen: " + pop.generation, 15, 25);
  text("f: " + pop.highestFitness, 15, 35);
  if (pop.fittestLastRound != null) {
    text("name: " + pop.fittestLastRound.firstName + " " + pop.fittestLastRound.lastName, 15, 45);
    text("dist: " + pop.fittestLastRound.distToEnd, 15, 55);
    Brain b = pop.fittestLastRound.brain;
    int x = (width / 2) - 20;
    int y = (height / 2)  - 20;
    for (int i = 0; i < b.output.values.length; i += 1) {
      text(i + ": " + b.output.values[i], x, y);
      y += 10;
    }
  }
}