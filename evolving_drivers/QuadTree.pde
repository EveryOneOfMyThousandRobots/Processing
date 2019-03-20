import java.awt.Rectangle;
final int QUAD_LIMIT = 5;
class QuadTree {
  Rectangle rect;
  ArrayList<Block> blocks = new ArrayList<Block>();
  ArrayList<QuadTree> children = new ArrayList<QuadTree>();
  PVector pos, dims;
  QuadTree(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
    
  }
  
  
  int get(Rectangle r, ArrayList<Block> list) {
    
    if (rect.intersects(r)) {
      for (Block b : blocks) {
        if (r.inside(b.x, b.y)) {
          list.add(b);
        }
      }
      
      for (QuadTree child : children) {
        child.get(r, list);
      }
    }
  
    return list.size();
  }
  
  void draw() {
    stroke(0);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
    for (QuadTree child : children) {
      child.draw();
    }
  }
  
  boolean add(Block b) {
    boolean returnVal = false;
    
    if (rect.inside(b.x,b.y)) {
      if (blocks.size() <  QUAD_LIMIT) {
        blocks.add(b);
        returnVal = true;
      } else {
        if (children.size() == 0) {
          float w2 = dims.x / 2;
          float h2 = dims.y / 2;
          children.add(new QuadTree(pos.x, pos.y, w2, h2));
          children.add(new QuadTree(pos.x, pos.y + h2, w2, h2));
          children.add(new QuadTree(pos.x + w2, pos.y + h2, w2, h2));
          children.add(new QuadTree(pos.x + w2, pos.y, w2, h2));
        }
        
        for (QuadTree child : children) {
          if (child.add(b)) {
            returnVal = true;
            break;
           
          }
        }
      }
      
    }
    
    
    return returnVal;
  }
}

final float BLOCK_SIZE = GRID_SIZE;
class Block {
  final int x, y;
  final int w, h;
  private PVector pos;
  private PVector dims;
  Rectangle rect;
  Block(float x, float y) {
    pos = new PVector(x,y);
    dims = new PVector(BLOCK_SIZE, BLOCK_SIZE);
    rect = new Rectangle((int)x, (int)y, (int)BLOCK_SIZE, (int)BLOCK_SIZE);
    this.x = (int)x;
    this.y = (int)y;
    this.w = (int)BLOCK_SIZE;
    this.h = (int)BLOCK_SIZE;
  }
  
  
  void draw() {
    fill(0);
    stroke(0);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}
