
class Item extends UniqueId {
  final String name;
  float totalValue = 0;
  int numComponents = 0;
  HashMap<Component, Integer> requires = new HashMap<Component, Integer>();
  HashMap<Component, Integer> contents = new HashMap<Component, Integer>();
  {
    name = getItemName();
  }

  String toString() {
    String output = "";

    output += name + " £" + nfc(totalValue, 2) ;
    for (Component c : requires.keySet()) {
      output += "\n\t" + c.name + " £" + nfc(c.value, 5) + " (" + requires.get(c) + ")";
    }

    return output;
  }
  
  boolean equals(Item item) {
    return item.id == this.id;
  }
  
  boolean isComplete() {
    return requires.size() == 0;
  }


  void addComponent(Component comp, int num) {
    if (requires.containsKey(comp)) {
      int required = requires.get(comp);

      contents.put(comp, required);
      requires.remove(comp);
    }
  }

  Item () {
    numComponents = floor(random(ITEM_MIN_COMPONENTS, ITEM_MAX_COMPONENTS));

    totalValue = 0;
    while (requires.size() < numComponents) {
      Component c = getRandomComponent();
      if (!requires.containsKey(c)) {
        int num = 1;//floor(random(1, 5));
        requires.put(c, num);
        totalValue += c.value * (float)num;
      }
    }
  }
}
