boolean intersects(PVector A1, PVector A2, PVector B1, PVector B2) {
  PVector normal = null;
  PVector vec = PVector.sub(B1, B2);
  normal = new PVector(vec.y, -vec.x);
  normal.normalize();
  //println(normal);

  PVector v1 = PVector.sub(A1, B1);
  PVector v2 = PVector.sub(A2, B1);
  float proj1 = v1.dot(normal);
  float proj2 = v2.dot(normal);

  if ((proj1 > 0 && proj2 < 0)||(proj1< 0 && proj2 > 0 )) {
    return true;
  } else {
    return false;
  }
}