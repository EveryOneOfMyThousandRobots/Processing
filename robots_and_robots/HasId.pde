class UniqueId {
  final int id;
  UniqueId(){
    id = getNextId("Object");
  }
  
  int hashCode() {
    return id;
  }
  
  boolean equals(UniqueId o) {
    return o.id == id;
  }
  
}
