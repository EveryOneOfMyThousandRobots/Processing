
PFont font;

void setup() {
  size(800, 800);
  font = createFont("Consolas", 10);
  textFont(font, 10);
  
  noLoop();
}

void draw() {
  background(0);
  fill(255);
  Recipe r = new Recipe();
  ArrayList<Product> pro = r.getProducts();
  int x = 5;
  int y = 10;
  for(Product p : pro) {
    text(p.toString(), x,y);
    y += 10;
  }
}
