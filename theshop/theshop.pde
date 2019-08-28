PFont fnt;
void setup() {
  size(1000, 1000);
  fnt = createFont("Consolas", 10);
  textFont(fnt);
  init();
}

void init() {
  createProducts();
  createCustomers();
}
int gen = 0;
int custIndex = -1;
int customerAttempts = floor(random(1, 5));
void draw() {
  background(0);


  custIndex += 1;
  Customer c = customers.get(custIndex);
  for (int i = 0; i < customerAttempts; i += 1) {
    c.pickProduct();
  }

  if (custIndex == customers.size() - 1) {
    custIndex = -1;
    generation();
    gen += 1;
    customerAttempts = floor(random(1, 5));
  }

  text("generation: " + gen, 10, 10);
  int x = 10;
  int y = 40;
  text("purchased", x, y);
  y += 10;
  for (Product p : purchased.keySet()) {
    String prc = str(purchased.get(p)).trim();
    text(pad(p.getName(), prc), x, y);
    y += 10;
  }
  y = 40;
  x = width / 4;
  text(pad("product", "gen", "avg. like"), x, y);
  y += 10;
  for (Product p : products) {
    text(p.getName(), x, y);
    y += 10;
  }
  
  y += 30;
  text("property", x,y);
  y += 10;
  for (Property p : glo_properties) {
    text(p.name, width / 4, y);
    y += 10;
  }
  y = 40;
  x = 40 + (width / 2);
  text(pad("id", "min", "chance", "gen"), x, y);
  y += 10;
  for (Customer cust : customers) {
    text(cust.getName(), x, y);
    y += 10;
  }
}

void generation() {
  //for (Customer c : customers) {
  //  c.pickProduct();
  //}

  resetProducts();
  nextCustomerGeneration();
}
