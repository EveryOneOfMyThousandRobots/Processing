//ArrayList<MP> checkedPoints = new ArrayList<MP>();
//ArrayList<MP> pointsToAdd = new ArrayList<MP>();

////color[][] myPixels;

//color[][] makePixelMap() {
//  color[][] px = new color[width][height]; 
//  loadPixels();
  
//  int idx = 0;
//  for (int x = 0; x < width; x += 1) {
//    for (int y = 0; y < height; y += 1) {
//      idx = x + y * width;
//      px[x][y] = pixels[idx];
//    }
//  }
  
//  return px;
//}

//color[][] fillMap(color[][] map, int sX, int sY) {
//  MP np = new MP(sX, sY);
  
//  for (MP a : checkedPoints) {
//    if (a.equals(np)) {
//      return map;
//    }
//  }
  
//  checkedPoints.add(new MP(sX, sY));
//  if (map[sX][sY] != color(0)) {
//    map[sX][sY] = color(255);
//  } else {
//    return map;
//  }
  
//  if (sX >0) {
//    map = fillMap(map, sX-1,sY);
//  }
  
//  if (sY > 0) {
//    map = fillMap(map, sX, sY-1);
//  }
  
//  if (sX<map.length-1) {
//    map = fillMap(map, sX+1, sY);
//  }
  
//  if (sY<map[0].length-1) {
//    map = fillMap(map, sX, sY+1);
//  }
  
  
//  return map;
  
  
//}

//class MP {
//  int x;
//  int y;

//  MP(int a, int b) {
//    x=a;
//    y=b;
//  }

//  boolean equals(MP other) {
//    return(x==other.x && y==other.y);
//  }
//}
