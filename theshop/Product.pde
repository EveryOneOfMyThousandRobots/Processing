
void buyOne(Product p) {
  if (!purchased.containsKey(p)) {
    purchased.put(p, 1);
  } else {
    purchased.put(p, purchased.get(p) + 1);
  }
}
class Product extends HasId {
  final String name;
  int generation;
  float sumLike = 0;
  int likes = 0;
  float avgLike = 0;
  //final int numProperties;
  DNA dna;
  //TreeMap<Property, Float> properties = new TreeMap<Property, Float>();
  Product () {
    name = getRandomName();
    dna = new DNA();
    //numProperties = floor(random(5,10));
    generation = 1;
    for (int i = 0; i < glo_properties.size(); i += 1 ) {
      dna.add(glo_properties.get(i).name, -1f, 1f);
      //properties.put(glo_properties.get(i), random(-1, 1));
    }
    dna.add(VALUE_FACTOR, -1f, 1f);
  }
  
  
  float getValue() {
    return ITEM_VALUE * abs(dna.get(VALUE_FACTOR));
  }

  Product (Product parent) {
    name = parent.name;
    dna = new DNA(parent.dna);
    this.generation = parent.generation + 1;
  }

  String propertiesToString() {
    String output = "";

    for (String p : dna.dna.keySet()) {
      if (output.length() > 0) {
        output += "|";
      }
      output += p + ":" + nfc(dna.get(p), 2);
    }

    return output;
  }

  String getName() {
    return pad(name, str(generation), nfc(getValue(),2));
  }

  String toString() {
    return name + propertiesToString();
  }
}


void createProducts() {
  for (int i = 0; i < NUM_PROPERTIES; i += 1) {
    createProperty();
  }
  for (int i = 0; i < NUM_PRODUCTS; i += 1) {
    createProduct();
  }
}

Property createProperty() {
  Property p = new Property();
  glo_properties.add(p);
  return p;
}

Product createProduct() {
  Product p = new Product();
  products.add(p);

  return p;
}

void printProducts() {
  for (int i = 0; i < products.size(); i += 1) {
    Product p = products.get(i);
    println(trim(pad(str(p.id), p.name)) + " " + p.propertiesToString());
  }
}

void resetProducts() {
  TreeMap<Product, Float> scores = new TreeMap<Product, Float>();

  float average = 0;
  float sum = 0;
  float max = -1;
  
  //calc score based on sales
  for (Product p : purchased.keySet()) {
    int v = purchased.get(p);
    float logv = log(v);
    sum += v;
    if (logv > max) {
      max = logv;
    }

    scores.put(p, logv);
  }
  
  //calc score based on likeability
  //for (Product p : products) {
  //  sum += p.avgLike;
  //  if (p.avgLike > max) {
  //    max = p.avgLike;
  //  }
  //  scores.put(p, p.avgLike);
  //}
  for (Product p : scores.keySet()) {
    scores.put(p, scores.get(p) / max);
  }



  average = sum / float(purchased.size());


  products.clear();



  for (Product p : purchased.keySet()) {
    //if (purchased.get(p) >= average) {
    if (random(1) < scores.get(p)) {
      products.add(new Product(p));
    }
    //}
  }

  while (products.size() < NUM_PRODUCTS ) {
    createProduct();
  }
  purchased.clear();
}
