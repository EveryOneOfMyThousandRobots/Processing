boolean OOB(Koch o) {
  if (((o.start.x < 0 || o.start.x > width) && (o.end.x < 0 || o.end.x > width)) || 
    ((o.start.y < 0 || o.start.y > height) && (o.end.y < 0 || o.end.y > height))) {
    return true;
  } else {
    return false;
  }
}