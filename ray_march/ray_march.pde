float angle;
PVector origin;
PVector angleVector;

float tileSize = 30;
class Block {
  PVector pos, dims, centre;
  Block(float x, float y, float w, float h) {
    pos = new PVector(floor(x), floor(y));
    dims = new PVector(floor(w), floor(h));
    centre = new PVector(pos.x + (dims.x/2), pos.y + (dims.y/2));
  }

   

  void draw() {
    stroke(128);
    fill(51);
    rect(pos.x, pos.y, dims.x, dims.y);
    stroke(255);
    ellipse(centre.x, centre.y, 3, 3);
  }
}
ArrayList<Block> blocks = new ArrayList<Block>();
void setup() {
  angleVector = PVector.fromAngle(angle);
  size(600, 600);
  origin = new PVector(random(width), random(height));
  blocks.add(new Block(0,0,width,tileSize));
  blocks.add(new Block(0,0,tileSize,height));
  blocks.add(new Block(width-tileSize,0,tileSize,height));
  blocks.add(new Block(0,height-tileSize,width,tileSize));
  for (int i = 0; i < 20; i += 1) {
    int x = floor(random(1, (width/tileSize)-1));
    int y = floor(random(1, (height/tileSize)-1));
    x *= tileSize;
    y *= tileSize;
    blocks.add(new Block(x, y, tileSize, tileSize));
  }
}


void draw() {
  background(0);
  angle += radians(0.5);
  angleVector.set(angleVector.x + cos(angle), angleVector.y + cos(angle));
  angleVector.normalize();
  boolean finished = false;
  PVector newOrigin = origin.copy();
  while (!finished) {
    
    Block closest = null;
    float shortestDist = Float.MAX_VALUE;
    
    
    for (Block block : blocks) {
      float dist = pointRectDist(block, newOrigin);
      if (closest == null || dist < shortestDist) {
        closest = block;
        shortestDist = dist;
      }
      
    }
    
    stroke(255);
    fill(255,16);
    ellipse(newOrigin.x, newOrigin.y, shortestDist*2, shortestDist*2);
    fill(255);
    ellipse(newOrigin.x, newOrigin.y, 5, 5);
    
    newOrigin = new PVector(newOrigin.x + shortestDist * cos(angle), newOrigin.y + shortestDist * sin(angle));
    
    
    if (shortestDist <= 1 || OOB(newOrigin.x, newOrigin.y)) {
      finished = true;
    }
  }
  
  for (Block block : blocks) {
    block.draw();
  }

  stroke(255);
  fill(255);
  ellipse(origin.x, origin.y, 5, 5);
}

boolean OOB(float x, float y) {
  return (x < 0 || x > width-1 || y < 0 || y > height-1);
}


float pointRectDist (Block r, PVector o) {
  float cx = max(min(o.x, r.pos.x+r.dims.x ), r.pos.x);
  float cy = max(min(o.y, r.pos.y+r.dims.y), r.pos.y);
  return sqrt( (o.x-cx)*(o.x-cx) + (o.y-cy)*(o.y-cy) );
}

float distToEdge(Block b, PVector origin) {
  float dx = max(abs(origin.x - b.centre.x) - (b.dims.x/2), 0);
  float dy = max(abs(origin.y - b.centre.y) - (b.dims.y/2), 0);
  return sqrt(dx * dx + dy * dy);
}

void mouseClicked() {
  origin.set(mouseX, mouseY);
}
