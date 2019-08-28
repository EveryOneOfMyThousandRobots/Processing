final String spaces = "                      ";
class Market {
  float gold = 0;
  TreeMap<Resource, Float> values = new TreeMap<Resource, Float>();
  TreeMap<Resource, Float> qtys = new TreeMap<Resource, Float>();
  ArrayList<Offer> offers = new ArrayList<Offer> ();
  ArrayList<Offer> completedTrades = new ArrayList<Offer>();

  float getMarketValue(Resource r) {
    return values.get(r);
  }



  void draw() {
    //sideBar.beginDraw();
    sideBar.fill(255);
    int y = 20;
    int x = 10;
    sideBar.text("offers:", x, y);
    y += 10;
    sideBar.text(pad("name", "resource", "qty", "price"), x, y);

    for (Offer o : offers) {
      y += 10;
      if (y > height / 4) break;
      String s = pad(o.seller.name, o.r.name, str(o.qty), nfc(o.totalPrice, 2));
      sideBar.text(s, x, y);
    }
    y = height / 4 + 10;
    sideBar.text("completed:", x, y);
    y += 10;
    sideBar.text(pad("seller", "buyer", "resource", "qty", "price"), x, y);
    y += 10;
    for (Offer o : completedTrades) {
      if (y > height / 2) break;
      String s = pad(o.seller.name, o.buyer.name, o.r.name, str(o.qty), nfc(o.totalPrice, 2));
      sideBar.text(s, x, y);
      y += 10;
    }

    y = height / 2 + 10;
    if (debug) {
      sideBar.text("recipes", x, y);
      y += 10;
      //sideBar.text(
      for (Recipe r : recipes) {
        String in = "";
        for (Resource rs : r.ingredients.keySet()) {
          if (in.length() > 0) {
            in += "+";
          }
          in += rs.name;
        }
        in += "=";
        boolean first = true;
        for (Resource rs : r.products.keySet()) {
          if (first) {
            first = false;
          } else {
            in += "+";
          }
          in += rs.name;
        }
        sideBar.text(in, x, y);
        y += 10;
      }
    } else {
      sideBar.text("resources: ", x, y);
      y += 10;
      sideBar.text(pad("name", "qty", "value", "base"), x, y);
      y += 10;    
      for (Resource r : resources) {

        String n = r.name;

        String q = str(int(qtys.get(r)));

        String v = nfc(values.get(r), 2);
        String b = nfc(r.value, 2);
        n = pad(n, q, v, b);
        sideBar.text(n, x, y);

        y += 10;
      }
    }
    //sideBar.endDraw();
  }


  void update() {
    //qtys.clear();
    //values.clear();
    //if (completedTrades.size() > 10) {
    while (completedTrades.size() > 20) {
      completedTrades.remove(0);
    }
    //}

    for (int i = offers.size() - 1; i >= 0; i -= 1) {
      offers.get(i).update();
    }

    for (Resource r : resources) {
      qtys.put(r, 0.0);
      values.put(r, r.value * random(0.99, 1.01));
    }

    for (Offer o : offers) {
      qtys.put(o.r, qtys.get(o.r) + o.qty);
    }

    for (Resource r : values.keySet()) {
      float v = values.get(r);
      float q = constrain(qtys.get(r), 0, 100);

      v *= 1 - pow(q * 0.01, 2);
      values.put(r, v);
    }
    
    for (Resource r : resources) {
      r.update();
    }
  }
}
Market market = new Market();
