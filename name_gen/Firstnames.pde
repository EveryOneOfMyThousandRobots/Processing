//HashMap<String, Integer> nameMap = new HashMap<String, Integer>();
//ArrayList<String> nameList = new ArrayList<String>();
HashMap<String, Float> nameChance = new HashMap<String, Float>();
ArrayList<String> firstNames;
/*
name,number,chance
 David,40201,1
 James,33886,0.842914355
 Andrew,32024,0.7965971
 John,28765,0.715529464
 */
Table table;
void makeFirstNames() {
  table = loadTable("firstnames.csv", "header");

  for (TableRow row : table.rows()) {
    String name = row.getString("name");
    float chance = row.getFloat("chance");
    if (name != null && name.length() > 0) {
      if (!nameChance.containsKey(name)) {
        nameChance.put(name, chance);
      }
    }
  }
  firstNames = new ArrayList<String>(nameChance.keySet());
  //for (int i = 0; i < 20; i += 1) {
  //  String name = firstNames.get(i);
    
  //  println(name + "\t\t" + nameChance.get(name));
  //}
}

String getFirstName() {
  String output = null;
  
  while(output == null) {
    float r = random(1);
    int idx = floor(random(firstNames.size()));
    String name = firstNames.get(idx);
    if (r <= nameChance.get(name)) {
      output = name;
    }
    
  }
  
  
  return output;
}
