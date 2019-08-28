 void setup() {
   JSONObject jsonFile = loadJSONObject("S:\\unity\\luatest\\Assets\\StreamingAssets\\data\\TileTypes\\TileTypes.json");
   
   JSONArray tileTypes = jsonFile.getJSONArray("tileTypes");
   
   for (int i = 0; i < tileTypes.size(); i += 1) {
     JSONObject tt = tileTypes.getJSONObject(i);
     String name = tt.getString("name");
     
      saveJSONObject(tt,"S:\\unity\\luatest\\Assets\\StreamingAssets\\data\\TileTypes\\" + name + ".json");
   }
 }
 
 void draw() {
 }
