int RESOURCE_ID = 0;
//ActionEntity gold = new ActionEntity("gold", true, false, false, color(255,255,0));

abstract class ActionEntity extends Entity implements Actionable {
  final public int id;
  {
    RESOURCE_ID += 1;
    id = RESOURCE_ID;
  }
  final public String name;
  final boolean mine;
  final boolean dropoff;
  final boolean pickup;
  color c;
  
  ActionEntity(String name, boolean mine, boolean pickup, boolean dropoff, color c) {
    this.mine = mine;
    this.pickup = pickup;
    this.dropoff = dropoff;
    this.name=name;
    this.c = c;
    
  }
  
  void clicked() {
    
  }
  
  boolean equals(ActionEntity o) {
    return o.id == id;
  }
  
  int hashCode() {
    return id * 17;
  }
  
  abstract void mine();
  
  abstract void pickup();
  
  abstract void update();
  
  
  abstract void dropoff();
  
  
  abstract void draw();
    
  
}

class Resource extends ActionEntity {
  //final ActionEntity type;
  PVector pos;
  Resource(String name, boolean mine, boolean pickup, boolean dropoff, color c, float x, float y) {
    super(name,mine, pickup,dropoff,c);
    //this.type = type;
    pos = new PVector(x,y);
  }
  
  void mine() {
    if (!mine) return; 
  }
  
  void dropoff() {
    if (!dropoff) return;
  }
  
  void pickup() {
    if (!pickup) return;
  }
  
  void update() {
    
  }
  
  void draw() {
    stroke(255);
    fill(c);
    rect(pos.x, pos.y, 32,32);
  }
}


interface Actionable {

  
  void mine();
  void pickup();
  void dropoff();
  
}
