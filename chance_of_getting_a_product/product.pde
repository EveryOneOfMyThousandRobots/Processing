enum QTY_TYPE {
  INT, FLOAT
}
class Product {
  String name;
  float chance;
  float qtyFrom, qtyTo;
  QTY_TYPE qtyType;
  float outputQty;
  
  
  Product(Product pro) {
    this.name = pro.name;
    this.chance = pro.chance;
    this.qtyFrom = pro.qtyFrom;
    this.qtyTo = pro.qtyTo;
    this.qtyType = pro.qtyType;
    
    setOutput();
  }
  
  String toString() {
    
    return padString(20,name,nfc(outputQty,2),str(qtyFrom), str(qtyTo), qtyType.toString(),nfc(chance,2));
  }
  


  Product(String name, float chance, float qtyFrom, float qtyTo, QTY_TYPE qtyType) {
    this.name = name;
    this.chance = chance;
    this.qtyFrom = qtyFrom;
    this.qtyTo = qtyTo;
    this.qtyType = qtyType;
    
  }

  void setOutput() {
    if (random(1) < chance) {
    switch (qtyType) {
    case INT:
      outputQty = floor(random(qtyFrom,qtyTo+1));
      break;
    case FLOAT:
      outputQty = random(qtyFrom, qtyTo);
      break;
    }
    } else {
      outputQty = 0;
    }
  }

  Product( QTY_TYPE qtyType) {
    this.name = getName();
    this.qtyType = qtyType;


    this.chance = random(1);
    switch (qtyType) {
    case INT:
      qtyFrom = 1;
      qtyTo = qtyFrom + floor(random(5));
      break;
    case FLOAT:
      qtyFrom = 1;
      qtyTo = qtyFrom + floor(random(5));
      break;
    }
  }
}
