import java.util.PriorityQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
final int W_WIDTH = 300;
final int W_HEIGHT = 300;
final int TS = 50;
final int TA = W_WIDTH / TS;
final int TD = W_HEIGHT / TS;
Tile[][] tiles;

long time_now = 0;
long time_last = 0;
long time_delta = 0;
float deltaTime = 0;
float displayDeltaTime = 0;
float displayDeltaTimeTimer = 0;
long time_accum = 0;

void settings() {
  size(W_WIDTH, W_HEIGHT);
}
Agent agent;

void setup() {

  tiles = new Tile[TA][TD];
  for (int x = 0; x< TA; x += 1) {
    for (int y = 0; y< TD; y += 1) {
      Tile t = new Tile(x, y);
      tiles[x][y] = t;
    }
  }
  agent = new Agent(5, 5);
  //for (int i =0; i < 50; i += 1) {

  //  agent.instructions.add("MOVE " + floor(random(TA)) + " " + floor(random(TD)));

  //  agent.instructions.add("WAIT 100");
  //}
  time_now = System.nanoTime() / (long)1e6;
  time_last = time_now;
}


void draw() {
  background(0);
  time_now = System.nanoTime() / (long)1e6;
  time_delta = time_now - time_last;
  time_last = time_now;
  time_accum += time_delta;
  deltaTime = (((float)time_delta) * ((1.0 / 60.0)));

  background(0);
  for (Tile[] ta : tiles) {
    for (Tile t : ta) {
      t.draw();
    }
  }
  agent.update();
  agent.draw();
  fill(255);
  text(myText, 0, 0, width, height);
  displayDeltaTimeTimer += deltaTime;
  if (displayDeltaTimeTimer >= 1) {
    
    displayDeltaTimeTimer -= 1;
    
    displayDeltaTime = deltaTime;
    println(displayDeltaTime + " " + time_accum + " " + frameRate);
    time_accum = 0;
  }
  text(nfc(displayDeltaTime,3), 10,30);
  //text(time_delta, 10, 10);
}
String myText = "";

 

 
void keyPressed() {
  if (keyCode == ENTER) {
    if (myText.length() > 0) {
      agent.instructions.add(myText.toUpperCase());
      myText = "";
    }
  } else if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
      myText = myText.substring(0, myText.length()-1);
    }
  } else if (keyCode == DELETE) {
    myText = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    myText = myText + key;
  }
}
