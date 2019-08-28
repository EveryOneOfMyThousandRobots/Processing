void setup() {
  noLoop();

  String[] tiles = {"grass", "dirt", "stone", "sand"};
  String[] ores = {"coal", "iron", "copper"};
  JSONArray output = new JSONArray();

  int l = 0;
  for (int i =0; i < tiles.length; i += 1) {
    String tile = tiles[i];
    for (int j = 0; j < ores.length; j += 1) {

      for (int k = 0; k < 8; k += 1) {
        String ore = ores[j];
        String name = "tiles::"+tile+"_"+ore+"_"+k;
        String base = "tiles::"+tile+"_"+k;
        String overlay = "tiles::"+ore+"_"+k;

        JSONObject json = new JSONObject();
        json.setString("name", name);
        json.setString("base", base);
        json.setString("overlay", overlay);
        output.setJSONObject(l, json);
        l += 1;
      }
    }
  }

  println(output.toString());
  JSONObject j = new JSONObject();
  j.setJSONArray("spriteCombos",output);
  saveJSONObject(j,"data/output.json");
  
}

void draw() {
}
