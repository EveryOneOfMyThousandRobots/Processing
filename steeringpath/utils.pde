PVector getNormalPoint(Path path, PVector loc, PVector start, PVector end) {
  PVector a = PVector.sub(loc, start);
  PVector b = PVector.sub(end, start);
  
  //float theta = PVector.angleBetween(a,b);
  //float d = a.mag() * cos(theta);
  b.normalize();
  b.mult( a.dot(b));
  return PVector.add(path.start, b);
  
}