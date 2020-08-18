import java.util.Arrays;

void settings() {
  size(LW * BW, LH * BH);
}

char[] validInput = "WASDwasd".toCharArray();

Player player;
void setup() {
  blocks = new Block[LW][LH];
  boolean playerAdded = false;
  for (int y = 0; y < LH; y += 1) {
    println("");
    for (int x = 0; x < LW; x += 1) {
      char c = level.charAt(y * LW + x);
      print(c);
      switch (c) {
      case 'M':
        blocks[x][y] = new AnyDirBlock(x,y);
        break;
      case '#':
        blocks[x][y] = new StaticBlock(x,y);
        break;
      case 'P':
        if (!playerAdded) {
          player = new Player(x,y);
          blocks[x][y] = player;
          
          playerAdded = true;
        }
        break;
      default:
        blocks[x][y] = null;
      }
    }
  }
}

boolean kp = false;
char k = 0;

void draw() {
  background(0);
  for (int y = 0; y < LH; y += 1) {
    int py = y * BH;
    for (int x = 0; x < LW; x += 1) {
      int px = x * BW;

      Block b = blocks[x][y];
      if (b != null) {
        b.draw(px, py);
      }
    }
  }

  boolean moving = false;
  int DIR = NORTH;

  if (kp) {
    switch (k) {
    case 'W':
      moving = true;
      DIR = NORTH;
      break;
    case 'A':
      moving = true;
      DIR = WEST;
      break;
    case 'S':
      moving = true;
      DIR = SOUTH;
      break;
    case 'D':
      moving = true;
      DIR = WEST;
      break;
    }
    println(k);


    if (moving) {
      switch (DIR) {
      case NORTH:
        boolean ok = false;
        for (int y = player.iy; y >= 0; y -= 1) {
          Block b = blocks[player.ix][y];
          if (b.canMove(DIR)) {
          }
          
        }

        break;
      case SOUTH:
        break;
      case EAST:
        break;
      case WEST:
        break;
      }
    }
  }

  kp = false;
}



void keyPressed() {
  kp = false;
  k = 0;
  for (char c : validInput) {
    if (c == key) {
      kp = true;
      k = Character.toUpperCase(c);
      break;
    }
  }
}
