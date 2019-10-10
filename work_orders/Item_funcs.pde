Item getRandomCmp() {
  return cmps.get(floor(random(cmps.size())));
}
void makeCmps() {
  for (int i = 0; i < 10; i += 1) {
    cmps.add(new Item(randomName()));
  }

  for (int i = 0; i < 5; i += 1) {
    Item prd = new Item(randomName());


    prd.setComponent(getRandomCmp(), floor(random(1, 5)));
    while (prd.components.size() < 3) {
      prd.setComponent(getRandomCmp(), floor(random(1, 5)));
    }
    prds.add(prd);
  }
  println("components");
  for (Item item : cmps) {
    println(item.toString());
  }
  
  println("products");
  for (Item item : prds) {
    println(item.toString());
  }
}

String randomName() {
  String n = null;
  while (n == null) {
    
    n = Integer.toString(floor(random(10E6, 10E9)),32).toUpperCase();
    if (names.contains(n)) {
      n = null;
    } else {
      names.add(n);
    }
  }
  return n;
}
