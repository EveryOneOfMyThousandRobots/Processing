ArrayList<Machine> machines = new ArrayList<Machine>();
final int SIZE = 50;
final float HALF_SIZE = float(SIZE) / 2.0;
final int IOSIZE = 10;
final float HALF_IOSIZE = float(IOSIZE) / 2.0;
PVector arenaStart, arenaDims;
PVector toolBarStart, toolBarDims;

boolean drawingWire = false;
PVector wireStart, wireEnd;
Output newWireFrom = null;
Input newWireTo = null;


void setup() {
  size(800, 800, P2D);
  arenaStart = new PVector(0, 0);
  arenaDims = new PVector(width, height - (SIZE * 3));
  toolBarStart = new PVector(0, height - (SIZE * 3));
  toolBarDims = new PVector(width, (SIZE * 3));
  machines.add(new Machine(true, false, 0, height / 2));
  machines.add(new Machine(false, true, width - SIZE, height / 2));
  machines.add(new Machine(false, false, width / 2, height / 2));
  textFont(createFont("Consolas", 12));
  wireStart = new PVector();
  wireEnd = new PVector();
}




void draw() {
  background(0);
  for (Machine m : machines) {
    m.update();
    m.draw();
  }

  stroke(255);
  fill(200, 128);
  rect(toolBarStart.x, toolBarStart.y, toolBarDims.x, toolBarDims.y);

  fill(200);
  rect(toolBarStart.x + 10, toolBarStart.y + 10, 100, 30);
  fill(0);
  text("New Machine", toolBarStart.x + 15, toolBarStart.y + 30);

  if (drawingWire) {
    stroke(255);
    line(wireStart.x, wireStart.y, wireEnd.x, wireEnd.y);
  }
}


void mousePressed() {

  for (Machine m : machines) {
    InputOutput n = m.clicked();
    if (n != null && n instanceof Output) {
      if (mouseButton == LEFT) {
        println("Clicked" + n.id);
        wireStart.set(n.pos);
        wireEnd.set(mouseX, mouseY);
        drawingWire = true;
        newWireFrom = (Output)n;
        break;
      } else if (mouseButton == RIGHT) {
        Output o = (Output)n;
        if (o.outgoing != null) {
          o.outgoing = null;
        }
      }
    }
  }
}

void mouseDragged() {
  if (drawingWire) {
    wireEnd.set(mouseX, mouseY);
  }
}

void mouseReleased() {
  drawingWire = false;
  for (Machine m : machines) {
    InputOutput n = m.clicked();
    if (n != null && n instanceof Input) {
      println("Clicked" + n.id + " isInput:" + (n instanceof Input) + " isOutput: " + (n instanceof Output));
      newWireTo = (Input) n;
      new Wire(newWireFrom, newWireTo);  
      newWireFrom = null;
      newWireTo = null;
      break;
    }
  }
}