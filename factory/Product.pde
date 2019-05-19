int ITEM_ID = 0;
class Item {
  int id;
  float quality = 1;
  {
    ITEM_ID += 1;
    id = ITEM_ID;
  }
  
  Item() {
    
  }
  
  
}