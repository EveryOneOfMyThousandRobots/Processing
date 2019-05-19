

void loadExternalFiles() {
  JSONArray rjson = null;
  rjson = loadJSONArray("materials.json");
  for (int i = 0; i < rjson.size(); i += 1) {
    materials.addMaterial(rjson.getJSONObject(i));
  }

  rjson = loadJSONArray("resources.json");

  for (int i = 0; i < rjson.size(); i += 1) {
    resources.addNewResourceType(rjson.getJSONObject(i));
  }

  rjson = loadJSONArray("structures.json");

  for (int i = 0; i < rjson.size(); i += 1) {

   structures.addStructureType(rjson.getJSONObject(i));



    //resourceTypeManager.addNewResourceType(id, name, gives, qty, color(c), solid);

    //ResourceType r = new ResourceType(id,name,gives,qty, color(c), solid);
  }
}
