class Block {
  PVector pos, dims;
  Block(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
  }
}

void BlockDraw(Block b) {
  stroke(255);
  fill(51);
  rect(b.pos.x, b.pos.y, b.dims.x, b.dims.y);
}

boolean BlockParticleCollide(Block b, Particle p ){
  return (p.pos.x > b.pos.x && p.pos.x < b.pos.x + b.dims.x &&
      p.pos.y > b.pos.y && p.pos.y < b.pos.y + b.dims.y );
}

boolean BlockPointCollide(Block b, PVector p ){
  return (p.x > b.pos.x && p.x < b.pos.x + b.dims.x &&
      p.y > b.pos.y && p.y < b.pos.y + b.dims.y );
}
