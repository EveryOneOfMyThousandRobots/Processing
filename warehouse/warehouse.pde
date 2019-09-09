import java.util.Collections;
import java.util.Arrays;
Node[][] nodes;
PImage lvlImg;
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 800;
final int NODE_SIZE = 20;
final int PLAY_AREA_WIDTH = 600;
final int PLAY_AREA_HEIGHT = 800;
final int NODES_ACROSS = PLAY_AREA_WIDTH / NODE_SIZE;
final int NODES_DOWN = PLAY_AREA_HEIGHT / NODE_SIZE;
ArrayList<Robot> robots = new ArrayList<Robot>();
ArrayList<String> progLines; 
Node dropoff;

Manager manager;
PFont font;
void settings() {

  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  lvlImg = loadImage("lvl001.png");
}

long timeNow, timeLast = System.nanoTime() / (long) 1e6, timeDelta;
float fTimeDelta;
void loadFile() {
  String[] sa = loadStrings("prog.txt");
  progLines = new ArrayList<String>();
  for(String s : sa) {
    progLines.add(s);
  }
  printArray(progLines);
}

void setup() {
  manager = new Manager();
  loadFile();
  font = createFont("Consolas", 8);
  textFont(font);
  nodes = new Node[NODES_ACROSS][NODES_DOWN];
  println("wxh=" +NODES_ACROSS + "x" + NODES_DOWN);
  lvlImg.loadPixels();
  for (int x = 0; x < NODES_ACROSS; x += 1) {
    for (int y = 0; y < NODES_DOWN; y += 1) {
      NodeType type = NodeType.PATH;



      int c = lvlImg.pixels[y * lvlImg.width + x]; 
      switch(c) {
      case 0xff000000:
        type = NodeType.WALL;
        break;
      case 0xffffff00:
        type = NodeType.BAY;
        break;
      case 0xffffffff:
        type = NodeType.PATH;
        break;
      case 0xffff0000:
        type = NodeType.DROPOFF;
        
        break;
      case 0xff00ff00:
        type = NodeType.PICKUP;
        break;
      }
      if (x == 0 || x == NODES_ACROSS - 1 || y == 0 || y == NODES_DOWN - 1) {
        type = NodeType.WALL;
      }

      nodes[x][y] = new Node(x, y, type);
      if (nodes[x][y].type == NodeType.DROPOFF) {
        dropoff = nodes[x][y];
      }
      
    }
  }
  setNodeNeighbours();
  initItems();
  initBays();
  for (int i = 0; i < 10; i += 1) {
    Node robotStart = null;
    while (robotStart == null) {
      robotStart = getRandomNode();
      if (robotStart.type != NodeType.PATH) {
        robotStart = null;
      }
    }
    robots.add(new Robot(robotStart.x, robotStart.y));
  }
  
  
}
float updatePeriod = 250;
float updateTimer = updatePeriod;
float deltaTime;
void draw() {
  timeNow = System.nanoTime() / (long)1e6;
  fTimeDelta = timeDelta = timeNow - timeLast;
  timeLast = timeNow;
  deltaTime = fTimeDelta * (60.0 / 1000.0);

  manager.update();
  background(0);

  for (int x = 0; x < NODES_ACROSS; x += 1) {
    for (int y = 0; y < NODES_DOWN; y += 1) {
      Node n = nodes[x][y];
      n.draw();
    }
  }

  for (Robot r : robots) {

    r.update(deltaTime);

    r.draw();
  }

  if (updateTimer <= 0) {
    updateTimer += updatePeriod;
  }

  for (Bay bay : bays) {
    bay.draw();
  }


  //draw play area
  stroke(255);
  noFill();
  rect(0, 0, PLAY_AREA_WIDTH, PLAY_AREA_HEIGHT);
  fill(255);
  text(updateTimer, PLAY_AREA_WIDTH + 10, 10);
  int x = PLAY_AREA_WIDTH + 2;
  int y = 30;
  for (Ticket ticket : manager.complete) {
    
    
    int requestedQty = 0;
    int pickedQty = 0;
    for (TicketItem item : ticket.pickList) {
      requestedQty += item.qtyTotal;
      pickedQty += item.qtyTotal - item.qtyLeftToPick;
    }
    
    String output = str(ticket.id) + " " + pickedQty + "/" + requestedQty;
    
    text(output, x,y);
    y += 10;
    
  }
}
