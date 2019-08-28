TreeMap<String, Integer> ids = new TreeMap<String, Integer>();
int getNextId(String name) {
  int id = 0;
  name = name.toUpperCase();
  if (ids.containsKey(name)) {
    id = ids.get(name) + 1;
    ids.put(name, id);
    
  } else {
    id = 1;
    ids.put(name,id);
  }
  
  return id;
  
}

class HasId {
  public final int id;
  {
     id = getNextId("ID");
  }
  
  int hashCode() {
    return (id * 11);
  }
  
  boolean equals(HasId o) {
    return o.id == id;
  }
  
   
  
}
