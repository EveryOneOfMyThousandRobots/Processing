PVector newVec() {
  float x = random(distFromEdge, width - distFromEdge);
  float y = random(distFromEdge, height - distFromEdge);
  return new PVector(x,y);
  
}