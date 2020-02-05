final int TILEW = 32;
final int TILEH = 16;

final int WORLDW = 24;
final int WORLDH = 24;

final int ORIGINX = 12;
final int ORIGINY = 4;


int[] world;

PFont font_ibm;


Sprite tileEmpty;
Sprite tileOutside;
void setup() {
  size(800, 600);

  font_ibm = createFont("Nouveau IBM", 12);
  textFont(font_ibm);

  tileEmpty = new Sprite("blank.png");
  tileOutside = new Sprite("outside_colours.png");

  world = new int[WORLDW * WORLDH];
}

float toScreenX(float x, float y) {
  return (ORIGINX * TILEW) + (x-y)*((float)TILEW/2.0);
}

float toScreenY(float x, float y) {
  return (ORIGINY * TILEH) + (x+y)*((float)TILEH/2.0);
}

int selectedX = 0;
int selectedY = 0;

void draw() {
  background(255);

  int cellX = floor(mouseX / TILEW);
  int cellY = floor(mouseY / TILEH);
  int offsetX = mouseX % TILEW;
  int offsetY = mouseY % TILEH;

  color c = tileOutside.getPix(offsetX, offsetY);



  fill(51);
  text("cell: (" + cellX + "," + cellY + ")\noff:  (" + offsetX + "," + offsetY + ")" + 
    "\nselect: (" + selectedX + "," + selectedY + ")" + 
    "\noffsetColour: " + Integer.toHexString(c), 10, 10);
  noFill();
 // stroke(255, 0, 0);
 // rect(cellX * TILEW, cellY * TILEH, TILEW, TILEH);

  selectedX = (cellY - ORIGINY) + (cellX - ORIGINX);
  selectedY = (cellY - ORIGINY) - (cellX - ORIGINX);

  switch (c & 0xffffff) {
  case 0xffff00:
    selectedX += 1;
    break;
  case 0xff0000:
    selectedY += 1;
    break;
  case 0x00ff00:
    selectedX -= 1;
    break;
  case 0x0000ff:
    selectedY -= 1;
    break;
  }

  stroke(255, 255, 0);
  fill(128, 32);
  rect(toScreenX(selectedX, selectedY), toScreenY(selectedX, selectedY), TILEW, TILEH);

  for (int y = 0; y < WORLDH; y += 1) {
    for (int x = 0; x < WORLDW; x += 1) {

      float sx = toScreenX(x, y);
      float sy = toScreenY(x, y);

      int tileType = world[ y * WORLDW + x];

      switch (tileType) {
      case 0:
        tileEmpty.draw(sx, sy);
        break;
      }
    }
  }
  //tileEmpty.draw(width/2,height/2);
}
