ArrayList<Machine> machines = new ArrayList<Machine>();
final int SIZE = 25;
PVector arenaStart, arenaDims;
PVector toolBarStart, toolBarDims;

void setup() {
  size(800, 800, P2D);
  arenaStart = new PVector(0,0);
  arenaDims = new PVector(width, height - (SIZE * 3));
  toolBarStart = new PVector(0, height - (SIZE * 3));
  toolBarDims = new PVector(width, (SIZE * 3));
  machines.add(new Machine(true, false, 0, height / 2));
  machines.add(new Machine(false, true, width - SIZE, height / 2));
  textFont(createFont("Consolas", 12));
}




void draw() {
  background(0);
  for (Machine m : machines) {
    m.update();
    m.draw();
   
  }
  
  stroke(255);
  fill(200,128);
  rect(toolBarStart.x, toolBarStart.y, toolBarDims.x, toolBarDims.y);
  
  fill(200);
  rect(toolBarStart.x + 10, toolBarStart.y + 10, 100, 30);
  fill(0);
  text("New Machine",toolBarStart.x + 15, toolBarStart.y + 30);
  
  
  
}