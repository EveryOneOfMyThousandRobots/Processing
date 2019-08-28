
ArrayList<Trader> traders = new ArrayList<Trader>();
class Trader {
  final int id;
  TreeMap<Resource, Float> inv = new TreeMap<Resource, Float>();

  {
    id = getNextId("TRADER");
  }
  PVector pos;
  float gold = 0;
  final Resource uses;
  float usesQty;
  final float recipeQty;
  final Resource makes;
  float makesQty;
  Offer offer = null;
  final float goldPerTurn;
  final float markup;

  Trader(float x, float y, float gold) {
    pos = new PVector(x, y);
    this.gold = gold;

    Resource u = getRandomResource();
    Resource m = null;
    while (m == null) {
      m = getRandomResource();
      if (u.equals(m)) {
        m = null;
      }
    }

    uses = u;
    usesQty = random(0.1, 3);
    makes = m;
    makesQty = random(0.1, 3);
    recipeQty = random(1, 4);
    goldPerTurn = random(0.01, 0.1);
    markup = random(1,2);

    traders.add(this);

    inv.put(getRandomResource(), random(1, 5));
    inv.put(makes, makesQty);
  }

  String toString() {
    return "trader ("+ id + ")";
  }

  void makeOffer() {
    if (offer == null) {
      for (Resource r : inv.keySet()) {
        float qty = inv.get(r);
        if (!r.equals(uses) && qty >= 1) {

          offer = new Offer(r, inv.get(r), (r.goldExchangeRate * qty) * markup, this);
          
          inv.put(r, 0.0f);
          break;
        }
      }
    }
  }
  void update() {
    makeOffer();
    checkOffers();
    makeProduct();
    gold -= goldPerTurn;
    inv.put(makes, makesQty);
    inv.put(uses, usesQty);
  }

  void makeProduct() {
    if (usesQty >= recipeQty) {
      makesQty += random(0.5,1.02);
      usesQty -= recipeQty;
    }
  }



  void checkOffers() {
    for (int i = offers.size()-1; i >= 0; i -= 1) {
      Offer o = offers.get(i);

      if (o.item.equals(uses) && gold >= o.price) {
        println(this.toString() + " bought " + o.qty + " " + o.item + " from " + o.postedBy + "  £" + o.price);
        o.postedBy.gold += o.price;
        o.postedBy.offer = null;
        gold -= o.price;
        usesQty += o.qty;
        offers.remove(i);
        break;
      }
    }
  }



  void draw() {
    stroke(255);
    fill(200, 10, 10);
    rect(pos.x, pos.y, 10, 10);
    fill(255);
    text(uses.name + " " + int(usesQty), pos.x + 15, pos.y);
    text(makes.name + " " + int(makesQty), pos.x + 15, pos.y + 10);
    text(gold, pos.x + 15, pos.y + 20);
  }
}
