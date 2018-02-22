final float LEARNING_RATE = 0.01;
int getNextId(String n) {
  n = n.toUpperCase();
  int rv = 0;
  boolean a = idList.get(n) != null;
  if (a == true) {
    rv = idList.get(n);
    rv += 1;
    idList.put(n, rv);
  } else {
    idList.put(n, 1);
    rv = 1;
  }

  return rv;
}



class hasId {
  final int id;
  hasId() {
    id = getNextId(this.getClass().toString());
  }


  int hashCode() {
    return (id * 17) + (id * 31) + (id * 101);
  }
}