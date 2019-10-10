class Item implements Comparable<Item> {
  HashMap<Item, Integer> components;
  final String name;
  Item (String name) {
    this.name = name;
  }
  
  String toString() {
    String output = "";
    
    
    if (components != null) {
      output = "product:"+name;
      for (Item item : components.keySet()) {
        output += "\n\t" + item.name + ":" + components.get(item);
      }
    } else {
      output = "component:"+name;
    }
    
      
    
    
    
    return output;
  }

  void setComponent(Item item, int qty) {
    if (components == null) {
      components = new HashMap<Item, Integer>();
    }

    if (!components.containsKey(item)) {

      components.put(item, qty);
    }
  }

  public int compareTo(Item o) {
    return name.compareTo(o.name);
  }

  public boolean equals(Object o) {
    if (o instanceof Item) {
      return (name.equals( ((Item)o).name));
    } else {
      return false;
    }
  }
}
