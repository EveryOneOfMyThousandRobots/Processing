byte getDigitMap(int v) {
  v = v % 10;
  byte map = 0;
  switch (v) {
  case 8:
    map = setBit(map, 6);
  case 0:
    map = setBit(map, 0);
    map = setBit(map, 1);
    map = setBit(map, 2);
    map = setBit(map, 3);
    map = setBit(map, 4);
    map = setBit(map, 5);
    break;
  case 6:
    map = setBit(map, 0);
    map = setBit(map, 5);
    map = setBit(map, 2);
    map = setBit(map, 3);
    map = setBit(map, 4);
    map = setBit(map, 6);  
    break;
  case 7:
    map = setBit(map, 0);
  case 1:
    map = setBit(map, 1);
    map = setBit(map, 2);
    break;
  case 5:
    map = setBit(map, 0);
    map = setBit(map, 5);
    map = setBit(map, 6);
    map = setBit(map, 2);
    map = setBit(map, 3);
    break;
  case 2:
    map = setBit(map, 0);
    map = setBit(map, 1);
    map = setBit(map, 6);
    map = setBit(map, 4);
    map = setBit(map, 3);
    break;
  case 3:
    map = setBit(map, 0);
    map = setBit(map, 6);
    map = setBit(map, 3);

    map = setBit(map, 1);
    map = setBit(map, 2);
    break;
  case 4:
    map = setBit(map, 5);
    map = setBit(map, 6);
    map = setBit(map, 1);
    map = setBit(map, 2);
    break;
  case 9:
    map = setBit(map, 0);
    map = setBit(map, 5);
    map = setBit(map, 1);
    map = setBit(map, 6);
    map = setBit(map, 2);
    map = setBit(map, 3);
  }


  return map;
}
