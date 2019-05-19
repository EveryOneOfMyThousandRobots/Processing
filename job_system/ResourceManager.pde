class ResourceManager {
  ArrayList<Resource> resources = new ArrayList<Resource>();
  void draw() {
    for (Resource r : resources) {
      r.draw();
    }
  }

  void removeHighlight() {
    for (Resource r : resources) {
      r.drawMe.highlighted = false;
    }
  }

  String toString() {
    String output = "";
    for (Resource r : resources) {
      output += r.toString() + "\n";
    }
    return output;
  }

  Resource clicked(float mx, float my) {
    for (Resource r : resources) {
      if (r.clickable.inside(mx-GUI_WIDTH, my)) {
        return r;
      }
    }
    return null;
  }

  int getResourcesInside(ArrayList<Resource> list, PVector l1, PVector r1) {
    PVector l1a = l1.copy();
    PVector r1a = r1.copy();
    l1a.x -= GUI_WIDTH;
    r1a.x -= GUI_WIDTH;

    //ArrayList<Resource> list = new ArrayList<Resource>();
    list.clear();

    for (Resource r : resources) {
      if (rectOverlap(l1a, r1a, r.pos, r.pos2)) {
        list.add(r);
      }
    }

    return list.size();
  }
  //}
  //class ResourceTypeManager {
  private HashMap<String, ResourceType> resourceTypes = new HashMap<String, ResourceType>();

  ArrayList<String> typeIds = new ArrayList<String>();
  HashMap<String, String> resourceTypeNames = new HashMap<String, String>();


  String types_toString() {

    String output = "";

    for (String i : resourceTypes.keySet()) {
      output += resourceTypes.get(i).toString() + "\n";
    }


    return output;
  }

  String getRandomTypeId() {
    return typeIds.get(floor(random(typeIds.size())));
  }

  void addNewResourceType(JSONObject json) {
    //println(json);
    String id = json.getString("id");
    int qty = json.getInt("quantity");
    String name = json.getString("name");
    String gives = json.getString("gives");
    boolean solid = json.getBoolean("solid");
    String colour = json.getString("colour");
    int c = Integer.valueOf(colour, 16);

    c += (255 << 24);

    addNewResourceType(id, name, gives, qty, color(c), solid);
  }

  void addNewResourceType(String id, String name, String gives, int qty, color col, boolean solid) {
    ResourceType r = new ResourceType(id, name, gives, qty, col, solid);
    addNewResourceType(r);
  }

  void addNewResourceType(ResourceType r) {
    if (!resourceTypes.containsKey(r.id)) {
      resourceTypes.put(r.id, r);
      resourceTypeNames.put(r.name, r.id);
      //resourceTypeIds.put(r.name.toUpperCase(), r.id);
      typeIds.add(r.id);
    }
  }

  String getResourceTypeIdByName(String name) {
    name = name.toUpperCase();
    if (resourceTypeNames.containsKey(name)) {
      return resourceTypeNames.get(name);
    }
    return null;
  }

  ResourceType getResourceTypeById(String tempId) {

    if (resourceTypes.containsKey(tempId)) {
      return resourceTypes.get(tempId);
    }


    return null;
  }

  ResourceType getResourceTypeByName(String name) {
    String tempId = getResourceTypeIdByName(name);
    return getResourceTypeById(tempId);
  }
}
