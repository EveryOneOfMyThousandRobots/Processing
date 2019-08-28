Block[][] arena;
int across = 12;
int down = 18;
int blockSize = 20;
enum BlockType {
  EMPTY,WALL;
}
class Block {
  color c;
  BlockType type;
  Block(color c, BlockType type) {
    this.c = c;
    this.type = type;
  }
  
}

Block WALL = new Block(color(255),BlockType.WALL);
Block EMPTY = new Block(color(0), BlockType.EMPTY);

void settings() {
  size(across * blockSize, down * blockSize);
}
void setup() {


  arena = new Block[across][down];
  for (int x = 0; x < arena.length; x += 1) {
    for (int y = 0; y < arena[x].length; y += 1) {
      if (x == 0 || x == arena.length-1 || y == arena[x].length-1) {
        arena[x][y] = WALL;
      } else {
        arena[x][y] = EMPTY;
      }
    }
  }
}


void draw() {
  background(0);

  for (int x = 0; x < arena.length; x += 1) {
    for (int y = 0; y < arena[x].length; y += 1) {
      Block b = arena[x][y];

      noStroke();
      fill(b.c);
      rect(x * blockSize, y * blockSize, blockSize, blockSize);
      switch(b.type) {
      case WALL:
      
        break;
      case EMPTY:
        break;
      }
    }
  }
}
