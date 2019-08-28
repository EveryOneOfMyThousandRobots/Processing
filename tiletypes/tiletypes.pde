String[] ores = {"iron", "copper", "coal"};
HashMap<String,String> productMap = new HashMap<String,String>();
int[] offsetA = {50, 100, 20};
int[] offsetB = {60, 110, 30};

class TileType {
  String name;
  float move;
  boolean hasOres;
  int h;
  boolean build;
  int id;
  String product = null;
  TileType(String name, float move, boolean hasOres, int h, boolean build) {
    this.name = name;
    this.move = move;
    this.hasOres = hasOres;
    this.h = h;
    this.build = build;
    ID += 1;
    id = ID;
    
    int l =name.indexOf("_"); 
    
    if (l > 0) {
      
      int len = name.length() - l - 1;
      println(name + " " + l + " " + len) ;
      String ore = name.substring(l+1);
      if (productMap.containsKey(ore)) {
        product = productMap.get(ore);
      }
    }
  }

  void saveType() {
    JSONObject json = new JSONObject();
    json.setString("name", name);
    json.setFloat("movementFactor", move);
    if (hasOres) {
      JSONArray varieties = new JSONArray();
      for (int i = 0; i < ores.length; i += 1) {
        String ore = ores[i];
        int offA = offsetA[i];
        int offB = offsetB[i];
        JSONObject o = new JSONObject();
        o.setString("name", name + "_" + ore);
        o.setInt("zOffsetA", offA);
        o.setInt("zOffsetB", offB);

        varieties.setJSONObject(i, o);
      }
      json.setJSONArray("varieties", varieties);
    }
    json.setInt("id", id);
    json.setInt("height", h);
    json.setBoolean("build", build);
    if (product != null) {
      json.setString("minedProduct", product);
    }
    saveJSONObject(json, "data/"+name+".json");
  }
}
int ID = 0;
ArrayList<TileType> types = new ArrayList<TileType>();
void setup() {
  noLoop();
  
  productMap.put("iron", "inv::iron_ore");
  productMap.put("copper", "inv::copper_ore");
  productMap.put("coal", "inv::coal");
  
  types.add(new TileType("water", 0.1, false, 1, false));
  
  types.add(new TileType("sand", 0.4, true, 150, true));
  types.add(new TileType("sand_iron", 0.4, false, -1, true));
  types.add(new TileType("sand_coal", 0.4, false, -1, true));
  types.add(new TileType("sand_copper", 0.4, false, -1, true));

  types.add(new TileType("dirt", 0.5, true, 200, true));
  types.add(new TileType("dirt_iron", 0.4, false, -1, true));
  types.add(new TileType("dirt_coal", 0.4, false, -1, true));
  types.add(new TileType("dirt_copper", 0.4, false, -1, true));

  types.add(new TileType("grass", 0.6, true, 250, true));
  types.add(new TileType("grass_iron", 0.4, false, -1, true));
  types.add(new TileType("grass_coal", 0.4, false, -1, true));
  types.add(new TileType("grass_copper", 0.4, false, -1, true));  
  
  types.add(new TileType("stone", 0.8, true, 500, true));
  types.add(new TileType("stone_iron", 0.4, false, -1, true));
  types.add(new TileType("stone_coal", 0.4, false, -1, true));
  types.add(new TileType("stone_copper", 0.4, false, -1, true));
  
  types.add(new TileType("empty", 0, false,-1,false));
  types.add(new TileType("bedrock", 0, false,-1,false));
  types.add(new TileType("concrete", 1, false,-1,true));
  
  types.add(new TileType("snow", 0.3, false, 1000, false));
  
  for (TileType t : types) {
    t.saveType();
  }
}

void draw() {
}
