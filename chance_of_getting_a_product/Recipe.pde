class Recipe {
  ArrayList<Product> products = new ArrayList<Product>();

  Recipe() {
    int num = floor(random(1, 10));

    for (int i = 0; i < num; i += 1) {
      products.add(new Product(QTY_TYPE.INT));
      products.add(new Product(QTY_TYPE.FLOAT));
    }
  }

  ArrayList<Product> getProducts() {
    ArrayList<Product> output = new ArrayList<Product>();
    for(Product pro : products) {
      output.add(new Product(pro));
    }
    
    return output;
    
  }
}
