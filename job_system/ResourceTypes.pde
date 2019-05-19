
class ResourceType {
  final String name;
  final Material gives;
  final String id;
  final int qty; 
  final color col;
  final boolean solid;
  ResourceType(String id, String name, String gives, int qty, color col, boolean solid) {

    //super(x, y, 32, color(0, 128, 0));
    this.name = name;
    this.gives = materials.getMaterialById(gives);
    this.id = id;
    this.qty = qty;
    this.col = col;
    this.solid = solid;
    //resourceTypeManager.addNewResourceType(this);
  }

  String toString() {
    return name + " (" + id + ") " + gives + " = " + qty + " col("+col+")";
  }
}

//int RESOURCE_ID = 0;
class Resource  {
  final String id = UUID.randomUUID().toString();
  
  DrawMe drawMe;
  Clickable clickable;
  ResourceType type;
  PVector pos;
  PVector pos2;
  Resource(String typeId, float x, float y) {
    
    
    
    clickable = new Clickable(x, y, RESOURCE_SIZE, RESOURCE_SIZE);
    this.type = resources.getResourceTypeById(typeId);
    drawMe = new DrawMe(x, y, RESOURCE_SIZE, this.type.col);
    pos = drawMe.pos.copy();
    pos2 = new PVector(pos.x + drawMe.s, pos.y + drawMe.s);
    
    
  }
  
  String toString() {
    return type.name + " (" + floor(pos.x) + "," + floor(pos.y) + ") " + Integer.toString(drawMe.c, 16);
  }
  
  void draw() {
    drawMe.draw();
  }

}
