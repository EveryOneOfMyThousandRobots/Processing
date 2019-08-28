class Product {
  String format, formatGroup, category;
  int W,L,H,weight,V;
  
  Product(String format, String formatGroup, int W, int L, int H, int weight) {
    
    this.format = format;
    this.formatGroup = formatGroup;
    this.W = W;
    this.L = L;
    this.H = H;
    this.weight = weight;
    V = CC(L,W,H);
    category = getCategory(this);
  }
  
  String toString() {
    return "product: " + format + "(" + formatGroup + ") " + W + "x" + L + "x" + H + "mm " + V + "cc " + weight + "g category:[" + category + "]";
  }
  
  
}

int CC(int A, int B, int C) {
  return ceil((float)(A * B * C) / 1000.00);
}

HashMap<String, String> formatMap = new HashMap<String, String>();
ArrayList<Product> products = new ArrayList<Product>();

String getCategory(Product pro) {
  
  if (pro.weight > 750) {
    return "v/weight over limit";
  } else if ((pro.formatGroup.equals("CD") || pro.formatGroup.equals("DVD")) && pro.V <= CC(200,160,30)) {
    return "i/small cd";
  } else if ((pro.formatGroup.equals("CD") || pro.formatGroup.equals("DVD")) && pro.V > CC(200,160,30) && pro.V <= CC(320,320,30)) {
    return "ii/large cd";
    
  } else if (pro.formatGroup.equals("LP") && pro.V <= CC(320,320,15)) {
    return "iii/small vinyl";
  } else if (pro.formatGroup.equals("LP") && pro.V > CC(320,320,15) && pro.V <= CC(320,320,30)) {
    return "iv/large vinyl";
  } else {
    return "v/no match";
    
  }
}

void setup() {
  size(600, 600);
  Table pcsv = loadTable("data.csv","header");
  
  for (TableRow row : pcsv.rows()) {
    String format = row.getString("Format");
    String formatGroup = row.getString("FormatGroup");
    int W = row.getInt("Width");
    int H = row.getInt("Height");
    int L = row.getInt("Length");
    int weight = row.getInt("Weight");
    
    products.add(new Product(format, formatGroup, W, L, H, weight));
  }
  Table output = new Table();
  output.addColumn("format");
  output.addColumn("format group");
  output.addColumn("width");
  output.addColumn("height");
  output.addColumn("length");
  output.addColumn("weight");
  output.addColumn("volume CC");
  output.addColumn("category");
  
  for (Product pro : products) {
    
    println(pro.toString());
    TableRow row = output.addRow();
    row.setString("format", pro.format);
    row.setString("format group", pro.formatGroup);
    row.setInt("width", pro.W);
    row.setInt("height", pro.H);
    row.setInt("length", pro.L);
    row.setInt("weight", pro.weight);
    row.setInt("volume CC", pro.V);
    row.setString("category", pro.category);
    
    
  }
  saveTable(output, "data/output.csv", "csv");
  

  noLoop();
}

void draw() {

}
