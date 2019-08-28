ArrayList<Offer> offers = new ArrayList<Offer>();

class Offer {
  final Resource item;
  final float qty;
  final float price;
  Trader postedBy = null;
  
  
  Offer(Resource item, float qty, float price, Trader trader) {
    this.item = item;
    this.qty = qty;
    this.price = price;
    this.postedBy = trader;
    offers.add(this);
  }
  
  
  String toString() {
    return item.toString() + " (" + nf(qty, 5, 2) + " @ " + nf(price, 5, 2) + ") " + postedBy.toString();
  }
  
}
