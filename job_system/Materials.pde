class MaterialManager {
  HashMap<String, Material> materials = new HashMap<String, Material>();
  
  MaterialManager() {
    
  }
  
  void addMaterial(JSONObject json) {
    String id = json.getString("id");
    String name = json.getString("name");
    Material m = new Material(id,name);
    materials.put(id,m);
  }
  
  Material getMaterialById(String m) {
    if (materials.containsKey(m)) {
      return materials.get(m);
    } else {
      return null;
    }
  }
}

class Material {
  final String id;
  final String name;
  
  Material(String id, String name) {
    this.id = id;
    this.name=name;
  }
  
  int hashCode() {
    return id.hashCode();
  }
  
  boolean equals(Material m) {
    return id.equals(m.id);
  }
  
}
