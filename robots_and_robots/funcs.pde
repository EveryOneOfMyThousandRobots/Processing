import java.util.HashSet;
HashMap<String, Integer> uniqueIds = new HashMap<String, Integer>();
int getNextId(String name) {
  int id = -1;

  name = name.toUpperCase().trim();

  if (uniqueIds.containsKey(name)) {
    id = uniqueIds.get(name) + 1;
    uniqueIds.put(name, id);
  } else {
    id = 1;
    uniqueIds.put(name, id);
  }





  return id;
}

void initTables() {
  incoming = new Incoming(width / 2, (IN_OUT_BIN_SIZE));
  outgoing = new Outgoing(width / 2, height - (IN_OUT_BIN_SIZE));
  workspace = new WorkSpace(width / 2, height / 2); 
  tables.add(incoming);
  tables.add( outgoing);
  tables.add( workspace);
  float x = COMPONENT_BIN_SIZE / 2;
  float y = 0;
  boolean printLeft = false;
  for (int i = 0; i < components.size(); i += 1) {
    y += COMPONENT_BIN_SIZE * 2;
    if (y >= height - (COMPONENT_BIN_SIZE / 2)) {
      y = COMPONENT_BIN_SIZE * 2;
      x = width - COMPONENT_BIN_SIZE;
      printLeft = true;
    }
    Component c = components.get(i);
    tables.add(new ComponentBin(x, y, c, printLeft));
  }
}

Component getRandomComponent() {
  return components.get(floor(random(components.size())));
}

void initComponents() {
  while (manu.size() < 5) {
    String s = getManuName();
    if (!manu.contains(s)) {
      manu.add(s);
    }
  }
  for (int i = 0; i < NUM_COMPONENTS; i += 1) {
    components.add(new Component());
  }
}

//void initItems() {
//  for (int i = 0; i < NUM_ITEMS; i += 1) {
//    items.add(new Item());
//  }
//}

//void printItems() {
//  for (Item item : items) {
//    println(item.toString());
//  }
//}

void printComponents() {
  for (Component cmp : components) {
    println(cmp.toString());
  }
}


String getItemName() {


  String name = "";
  name += getManu();
  name += "-"+getNamePart(floor(random(1, 4)), nums);
  name += getNamePart(floor(random(1, 6)), alphabet);
  name += "-"+getNamePart(floor(random(1, 6)), nums);



  return name;
}
String getComponentName() {


  String name = "";
  name += getManu();
  name += "-"+getNamePart(floor(random(1, 4)), nums);
  name += getNamePart(floor(random(1, 4)), alphabet);
  name += "-"+getNamePart(floor(random(1, 4)), nums);



  return name;
}

String getManu() {
  return manu.get(floor(random(manu.size())));
}

String getManuName() {
  return getNamePart(4, alphabet);
}

String getNamePart(int n, String fromAlphabet) {
  String out = "";
  int len = fromAlphabet.length();

  for (int i = 0; i < n; i += 1) {
    out += str(fromAlphabet.charAt(floor(random(len))));
  }


  return out;
}
