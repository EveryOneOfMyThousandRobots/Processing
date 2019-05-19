class StructureManager {
  HashMap<String, StructureType> structureTypes = new HashMap<String, StructureType>();
  ArrayList<Structure> structures = new ArrayList<Structure>();

  void addStructureType(JSONObject json) {
    //JSONObject json = rjson.getJSONObject(i);
    String id = json.getString("id");
    String name = json.getString("name");
    String colour = json.getString("colour");
    int c = Integer.valueOf(colour, 16);
    String slots = json.getString("inventory_slots");
    int iSlots = 0;
    if (slots.equals("infinite")) {
      iSlots = -1;
    } else {
      iSlots = Integer.valueOf(slots);
    }
    JSONArray ja = json.getJSONArray("receives");
    ArrayList<String> receives = new ArrayList<String>();
    boolean receivesAll = false;
    for (int j = 0; j < ja.size(); j += 1) {
      JSONObject jas = ja.getJSONObject(j);
      String jid = jas.getString("id");
      if (jid.equals("all")) {
        receivesAll = true;
      } else {
        receives.add(jid);
      }
    }

    c += (255 << 24);
    addStructureType(id, name, receives, c, iSlots, receivesAll);
  }

  void addStructureType(String id, String name, ArrayList<String> receives, color c, int slots, boolean receivesAll) {
    if (!structureTypes.containsKey(id)) {
      structureTypes.put(id, new StructureType(id, name, receives, c, slots, receivesAll));
    }
  }

  String toString() {
    String output = "";

    for (String s : structureTypes.keySet()) {
      output += structureTypes.get(s).toString() + "\n";
    }


    return output;
  }

  StructureType getStructureTypeById(String id) {
    if (structureTypes.containsKey(id)) {
      return structureTypes.get(id);
    } else {
      return null;
    }
  }

  void draw() {
    for (Structure s : structures) {
      s.draw();
    }
  }
}

class StructureType {
  final String id;
  final String name;
  private final ArrayList<String> receives;
  final color c;
  final int slots;
  final boolean receivesAll;

  StructureType (String id, String name, ArrayList<String> receives, color c, int slots, boolean receivesAll) {
    this.id = id;
    this.name = name;
    this.receives = receives;
    this.c = c;
    this.slots = slots;
    this.receivesAll = receivesAll;
  }

  int hashCode() {
    return id.hashCode();
  }

  boolean equals(StructureType o) {
    return id.equals(o.id);
  }

  String toString() {
    return id + " " + name + " " + slots;
  }
}

class Structure {
  final String id = UUID.randomUUID().toString();
  PVector pos;
  final StructureType type;
  Clickable click;
  
  HashMap<Material,Integer> contents = new HashMap<Material,Integer>();

  DrawMe d;

  Structure(float x, float y, StructureType type) {
    pos = new PVector(x, y);
    this.type = type;
    d = new DrawMe(x, y, RESOURCE_SIZE, type.c);
    click  = new Clickable(x, y, RESOURCE_SIZE, RESOURCE_SIZE);
  }

  void draw() {
    d.draw();
    
    GAME_WINDOW.fill(255);
    GAME_WINDOW.text(getContentsString(), pos.x + RESOURCE_SIZE, pos.y);
    
  }
  
  String getContentsString() {
    String output = "";
    for (Material m : contents.keySet()) {
      output += m.name + " " + contents.get(m) + "\n";
    }
    return output;
  }
  
  



  void addMaterial(Material m, int qty) {
    if (contents.containsKey(m)) {
      int q = contents.get(m);
      q += qty;
      contents.put(m, q);
    } else {
      contents.put(m, qty);
    }
  }
}
