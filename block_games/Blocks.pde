abstract class Block {
  int ix, iy;
  Block(int ix, int iy) {
    setIndex(ix, iy);
  }

  void setIndex(int ix, int iy) {
    this.ix = ix;
    this.iy = iy;
  }


  abstract void draw(int x, int y);
  abstract boolean canMove(int DIR);
}

class StaticBlock extends Block {

  StaticBlock(int ix, int iy) {
    super(ix, iy);
  }
  @Override 
    boolean canMove(int DIR) {
    return false;
  }

  @Override 
    void draw(int x, int y) {
    noStroke();
    fill(0, 0, 255);
    rect(x, y, BW, BH);
  }
}

class AnyDirBlock extends Block {

  AnyDirBlock(int ix, int iy) {
    super(ix, iy);
  }


  @Override 
    boolean canMove(int DIR) {
    return true;
  }
  @Override 
    void draw(int x, int y) {
    noStroke();
    fill(255, 15, 20);
    rect(x, y, BW, BH);
  }
}

class Player extends Block {

  @Override 
    boolean canMove(int DIR) {
    return true;
  }

  Player(int ix, int iy) {
    super(ix, iy);
  }
  @Override 
    void draw(int x, int y) {
    noStroke();
    fill(255);
    rect(x, y, BW, BH);
  }
}
