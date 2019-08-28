import java.util.Collections;
import java.util.Comparator;

ArrayList<Block> blocks = new ArrayList<Block>();
BlockComparator bcomp = new BlockComparator();

final int W = 4, H = 8;

void setup() {
  size(400,400);
  for(float i = 0; i < 0.8; i += 0.005) {
    blocks.add(new Block(W,H,i));
  }
  Collections.sort(blocks, bcomp);
  
  
}
void draw() {
  background(0);
  int x = 0;
  int y = 0;
  for (Block b : blocks ) {
    image(b.img, x,y);
    x += W + 2;
    
    if (x > width) {
      x = 0;
      y += H + 2;
    }
  }
}

class Block implements Comparable <Block>{
  PGraphics img;
  int count = 0;
  Block(int w, int h, float density) {
    img = createGraphics(w,h);
    
    img.beginDraw();
    img.background(0);
    img.stroke(255);
    //img.loadPixels();
    
    for (int x = 0; x < img.width; x += 1) {
      for (int y = 0; y < img.height; y += 1) {
        if (random(1) <= density) {
          img.point(x,y);
          count += 1;
        }
      }
    }
    //img.updatePixels();
    img.endDraw();
    
  }
  
  int compareTo(Block o) {
    if (this.count > o.count) {
      return 1;
    } else if (this.count < o.count) {
      return -1;
    } else {
      return 0;
    }
  }
}


class BlockComparator implements Comparator<Block> {
  int compare(Block a, Block b) {
    return a.compareTo(b);
  }
}
