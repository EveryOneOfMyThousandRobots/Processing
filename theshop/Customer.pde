



class Customer extends HasId {
  DNA dna;
  int purchases = 0;
  int generation = 1;
  final String name;
  String parentName = "";
  ArrayList<Product> purchasedProducts = new ArrayList<Product>();
  float money = 15;
  Customer() {
    dna = new DNA();
    for (int i = 0; i < glo_properties.size(); i += 1 ) {
      dna.add(glo_properties.get(i).name, -1f, 1f);
      //properties.put(glo_properties.get(i), random(-1, 1));
    }
    dna.add(MIN_LIKE_AMOUNT, 0f, 1f);
    dna.add(LIKE_FACTOR, 0f, 1f);
    dna.add(CHANCE_TO_BUY, 0f, 1f);
    name = getRandomName();
  }

  String getName() {
    return pad(name, parentName, dna.getString(CHANCE_TO_BUY), str(generation));
  }

  Customer(Customer parent) {
    this.dna = new DNA(parent.dna);
    this.generation = parent.generation + 1;
    this.name = parent.name;
    this.parentName = parent.name + " " + parent.id;
  }

  Customer child() {
    return new Customer(this);
  }

  float getLikeAmount(Product p ) {
    float like = 0;
    float lf = dna.get(LIKE_FACTOR);
    for (int i = 0; i < glo_properties.size(); i += 1 ) {
      Property prop = glo_properties.get(i);
      float me = dna.get(prop.name);
      float pro = p.dna.get(prop.name);


      like += lf * pow(me - pro, 2);
    }
    like += (ITEM_VALUE - p.getValue()) / ITEM_VALUE;
    p.sumLike += like;
    p.likes += 1;
    p.avgLike = p.sumLike / float(p.likes);


    return like;
  }
  
  int compareTo(Customer o) {
    String s1 = this.name.toUpperCase() + this.id;
    String s2 = o.name.toUpperCase() + o.id;
    return s1.compareTo(s2); 
  }

  void pickProduct() {
    TreeMap<Product, Float> chooseFrom = new TreeMap<Product, Float>();
    Product chosen = null;
    float max = -1;
    float minimum = dna.get(MIN_LIKE_AMOUNT);
    float chance = dna.get(CHANCE_TO_BUY);

    for (Product p : products) {
      if (!purchasedProducts.contains(p)) {
        chooseFrom.put(p, getLikeAmount(p));
      }
    }

    for (Product p : chooseFrom.keySet()) {
      float l = chooseFrom.get(p);
      if (l > max && l >= minimum) {
        chosen = p;
        max = l;
      }
    }

    if (chosen != null) {
      if (!purchasedProducts.contains(chosen) && random(1) < chance && money >= chosen.getValue()) {
        buyOne(chosen);
        purchases += 1;
        purchasedProducts.add(chosen);
        money -= chosen.getValue();
      }
    }
  }
}


void nextCustomerGeneration() {
  TreeMap<Customer, Float> scores = new TreeMap<Customer, Float>();

  float max = -1;
  float sum = 0;
  for (Customer c : customers) {
    scores.put(c, float(c.purchases));
    sum += c.purchases;
    if (c.purchases > max) {
      max = c.purchases;
    }
  }
  float avg = sum / customers.size();
  
  if (max == 0) max = 1;
  avg /= max;
  for (Customer c : scores.keySet()) {
    float v = scores.get(c);
    scores.put(c, v / max);
  }
  ArrayList<Customer> children = new ArrayList<Customer>();

  //while (children.size() < NUM_CUSTOMERS / 2) { 
    int r = floor(random(0, NUM_CUSTOMERS / 2));
    for (int i = 0; i < r; i += 1) {
      children.add(new Customer());
    }
    
    
    for (Customer c : scores.keySet()) {
      float s = scores.get(c);
      if (random(1) < s && children.size() < NUM_CUSTOMERS) {
        if (s > avg && random(10) < s ) {
          Customer cc = c.child();
          cc.money += c.money / 2;
          c.money /= 2;
          children.add(cc);
          cc = c.child();
          cc.money += c.money;
          children.add(cc);
        } else {
          Customer cc = c.child();
          cc.money += c.money;
          children.add(cc);
        }
        
      }
    }
  //}

  while (children.size() < NUM_CUSTOMERS) {
    children.add(new Customer());
  }

  customers = children;
  customers.sort(custComparator);
}


void createCustomers() {
  for (int i = 0; i < NUM_CUSTOMERS; i += 1) {
    createCustomer();
  }
}
Customer createCustomer() {

  Customer c = new Customer();
  customers.add(c);
  return c;
}
