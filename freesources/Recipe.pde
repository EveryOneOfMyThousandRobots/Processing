import java.util.TreeMap;
class Recipe {
  TreeMap<Resource, Float> ingredients = new TreeMap<Resource, Float>();
  TreeMap<Resource, Float> produces = new TreeMap<Resource, Float>();
  
  Recipe() {
    int numIn = floor(random(1,4));
    int numOut = floor(random(1,3));
    for (int in = 0; in < numIn; in += 1) {
      //ingredients.put(
    }
  }
}
