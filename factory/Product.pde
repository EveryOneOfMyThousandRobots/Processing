int ITEM_ID = 0;
class Item {
  int id;
  {
    ITEM_ID += 1;
    id = ITEM_ID;
  }
}