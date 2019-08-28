ArrayList<Factory> factories = new ArrayList<Factory>();

class Factory extends HasId implements Comparable<Factory> {
  Recipe recipe;
  String name;
  boolean importer = false; 

  int compareTo(Factory o) {
    return name.compareTo(o.name);
  }

  TreeMap<Resource, Float> inv = new TreeMap<Resource, Float>();
  float gold;
  int timer;
  int timerMax;
  float runningCost;
  PVector pos;
  int coolDownTimer;
  int coolDownLength;
  color col;
  float markup;
  int age;
  float makingQty = 0;

  Factory(float x, float y) {
    col = color(random(64, 200), random(64, 200), random(64, 200));
    name = getComanyName();
    pos = new PVector(x, y);
    recipe = getRandomRecipe();
    //println(recipe);
    gold = 1000; //random(500, 1000);
    for (Resource p : recipe.ingredients.keySet()) {
      inv.put(p, random(10) * recipe.ingredients.get(p));
    }

    factories.add(this);
    timerMax = recipe.timeToMake;
    runningCost = (float(recipe.numProducts) * 0.1) + (float(recipe.numIngredients) * 0.1) + random(0.01, 0.1);
    markup = random(1, 2);
    coolDownLength = floor(random(50, 200));
  }

  void setImporter() {
    importer = true;
    runningCost = 0;
    gold = 1000;
    markup = 0.5;
    coolDownLength = floor(random(10, 50));
    name = "importer";
  }

  void makeOffer() {
    for (Resource r : inv.keySet()) {
      if (!recipe.ingredients.keySet().contains(r) || importer) {
        int qty = constrain(floor(getQty(r)), 0, 10);
        if (qty >= 1) {
          float v = market.getMarketValue(r);
          v *= 1.0 - (float(qty) / 100.0);
          v *= markup;
          if (v > 0) {
            Offer o = new Offer(r, qty, v, floor(random(100, 500)), this);
            coolDownTimer = coolDownLength;
            if (!importer) {
              break;
            }
          }
        }
      }
    }
  }

  void update() { //<>//

    if (importer) {
      if (random(1) < 0.01) {
        Resource r = getRandomResource();
        if (getQty(r) < 5) {
          addResource(r, random(1, 5));
        }
      }
    }
    age += 1;
    gold -= runningCost;
    if (coolDownTimer > 0) {
      coolDownTimer -= 1;
    }
    if (timer > 0 ) {
      //working
      timer -= 1;
      if (timer == 0) { //done
        for (Resource p : recipe.products.keySet()) {
          this.addResource(p, makingQty * recipe.products.get(p));
        }
      }
    } else {
      if (coolDownTimer == 0) {
        makeOffer();
        checkOffers();

        makingQty = 0;
        boolean make = true;
        int attemps = 0;
        while (make && !importer && attemps < 5) {
          attemps += 1;
          //println(millis() + " within loop");
          make = true;
          for (Resource r : recipe.ingredients.keySet()) {
            float needed = recipe.ingredients.get(r);
            float have = getQty(r);

            if (have < needed) {
              make = false;
              break;
            }
          }

          if (make) { //<>//
            for (Resource r : recipe.ingredients.keySet()) {
              removeResource(r, recipe.ingredients.get(r));
              //inv.put(r, inv.get(r) - recipe.ingredients.get(r));
            }
            makingQty += 1;
            timer = recipe.timeToMake;
          } else {
            break;
          }
        }
      }
    }
  }

  float getQty(Resource r ) {
    if (inv.containsKey(r)) {
      return inv.get(r);
    } else {
      return 0;
    }
  }

  boolean canRemove(Resource r, float qty) {
    if (getQty(r) >= qty) {
      return true;
    } else {
      return false;
    }
  }

  void removeResource(Resource r, float qty) {
    qty = abs(qty);
    if (canRemove(r, qty)) {
      inv.put(r, inv.get(r) - qty);
    }
  }

  void addResource(Resource r, float qty) {
    if (inv.keySet().contains(r)) {
      float eq = inv.get(r);
      inv.put(r, eq + qty);
    } else {
      inv.put(r, qty);
    }
  }

  void checkOffers() {
    if (importer) return;
    ArrayList<Offer> interested = new ArrayList<Offer>();
    for (int i = market.offers.size() - 1; i >= 0; i -= 1) {
      Offer o = market.offers.get(i);

      if (recipe.ingredients.keySet().contains(o.r)) {
        float offerQty = o.qty;
        float alreadyHave = getQty(o.r);
        float recipeQty = recipe.ingredients.get(o.r);
        float mv = market.getMarketValue(o.r);
        boolean go = true;
        if (o.totalPrice > mv * o.qty) {
          if (random(1) < 0.5) {
            go = false;
          }
        }
        if (go && gold >= o.totalPrice && alreadyHave < recipeQty * 2) {
          interested.add(o);
          //o.buy(this);
        }
      }
    }
    float lowestUnitCost = -1;
    Offer buyMe = null;
    for (Offer o : interested) {
      if (lowestUnitCost == -1 || o.unitPrice < lowestUnitCost) {
        lowestUnitCost = o.unitPrice;
        buyMe = o;
      }
    }
    if (buyMe != null) {
      buyMe.buy(this);
    }
  }

  void draw() {
    stroke(255);
    fill(col);
    rect(pos.x, pos.y, FACTORY_SIZE, FACTORY_SIZE);

    fill(0);
    text(name, pos.x + 5, pos.y + 10);
    text(int(gold), pos.x + 5, pos.y + 20);
    float y = pos.y + 30;

    for (Resource r : inv.keySet()) {
      if (y > pos.y + FACTORY_SIZE - 10) break;  
      String type = " ";
      if (recipe.ingredients.keySet().contains(r)) {
        type = "i";
      }

      if (recipe.products.keySet().contains(r)) {
        type = "p";
      }
      text(type + " " + r.id + " " + nfc(inv.get(r), 2), pos.x + 10, y);
      y += 10;
    }

    //text("recipe: " + recipe.numIngredients + "=>" + recipe.numProducts, pos.x + 5, y + 10);
    //text("gold: " + int(gold), pos.x + 5, y + 20);
    stroke(0);
    //strokeWeight(2);
    //fill(255);
    noFill();
    arc(pos.x + 10, pos.y + FACTORY_SIZE - 10, 20, 20, 0, map(timer, 0, timerMax, 0, TWO_PI));
    fill(0);
    textAlign(RIGHT);
    text(age, pos.x + FACTORY_SIZE - 1, pos.y + FACTORY_SIZE - 1);
    textAlign(LEFT);
  }
}
