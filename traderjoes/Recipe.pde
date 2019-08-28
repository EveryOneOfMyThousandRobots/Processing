ArrayList<Recipe> recipes = new ArrayList<Recipe>();

Recipe getRandomRecipe() {
  return recipes.get(floor(random(recipes.size())));
  
}
class Recipe extends HasId {
  int timeToMake;
  //int timer = 0;

  int numIngredients;
  int numProducts; 

  TreeMap<Resource, Float> ingredients = new TreeMap<Resource, Float>();
  TreeMap<Resource, Float> products  = new TreeMap<Resource, Float>();

  Recipe(int time) {
    this.timeToMake = time;
    recipes.add(this);
  }

  Recipe() {
    this(floor(random(10, 100)));
  }

  String toString() {
    String output = "\n" + id + " time: " + timeToMake + " In: ";

    if (ingredients.size() == 0) {
      output += "none";
    } else {
      //output += "\n";
      for (Resource r : ingredients.keySet()) {
        output += "\n\t"+ r.name + " (" + ingredients.get(r) + ")";
      }
    }
    output += "\nOut:";
    for (Resource r : products.keySet()) {
      output += "\n\t"+ r.name + " (" + products.get(r) + ")"; 
    }

    output += "\n";

    return output;
  }

  void randomise() {
    numIngredients = floor(random(0, 3));
    numProducts  = floor(random(1, 2.9));

    for (int i = 0; i < numIngredients; i += 1) {
      ingredients.put(getRandomResource(), random(1, 3));
    }
    float pfactor = 1;
    if (numIngredients == 0) {
      pfactor = random(0.1,1);
    }
    while (products.size() < numProducts) {
      Resource r = getRandomResource();
      if (!ingredients.keySet().contains(r)) {
        products.put(r, random(0.1, 3) * pfactor);
      }
    }
    
    if (numIngredients == 0){
      timeToMake *= (2 + numProducts);
    }
  }

  void addIngredient(Resource resource, float qty) {
    ingredients.put(resource, qty);
  }

  void addProduct(Resource resource, float qty) {
    products.put(resource, qty);
  }
}

void makeRecipes() {
  int num = (STARTING_LOW_RESOURCES + STARTING_HIGH_RESOURCES) * 2;
  for (int i = 0; i < num; i += 1) {
    Recipe r = new Recipe();
    r.randomise();
  }
}
