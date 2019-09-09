int ITEM_ID = 0;
class Item {
  final int id;
  int totalRequested = 0;
  {
    ITEM_ID += 1;
    id = ITEM_ID;
  }
  
  int hashCode() {
    return Integer.toHexString(id).hashCode();
  }
  
  @Override
  boolean equals(Object o) {
    if (!(o instanceof Item)) {
      return false;
    } else {
      Item item = (Item) o;
      return item.id == id;
    }
  }
  
  HashMap<Bay, Integer> getBays() {
    HashMap<Bay,Integer> itemBays = new HashMap<Bay,Integer>();
    
    for (Bay bay : bays) {
      int qty = bay.getQty(this);
      if (qty > 0) {
        itemBays.put(bay,qty);
      }
    }
    
    
    return itemBays;
  }
}

ArrayList<Item> items = new ArrayList<Item>();

Item getRandomItem() {
  return items.get(floor(random(items.size())));
}
void initItems() {
  int r = floor(random(10,30));
  for (int i = 0; i < r; i += 1) {
    items.add(new Item());
  }
}
