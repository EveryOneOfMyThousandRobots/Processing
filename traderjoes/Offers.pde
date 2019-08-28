class Offer extends HasId {
  final Resource r;
  final int qty;
  final float unitPrice;
  final float totalPrice;
  final Factory seller;
  private Factory buyer;
  final int expires;
  private int timer;
  Offer(Resource r, int qty, float unitPrice, int expires, Factory f) {
    this.seller = f;
    this.r = r;
    this.qty = qty;
    this.unitPrice = unitPrice;
    totalPrice = float(qty) * unitPrice;
    f.inv.put(r, f.inv.get(r) - qty);
    this.expires = expires;
    timer = expires;
    market.offers.add(this);
  }
  
  

  void update() {
    timer -= 1;
    if (timer <= 0) {
      market.offers.remove(this);
      seller.addResource(r , qty);
      //seller.inv.put(r, seller.inv.get(r) + qty);
    }
  }

  void buy(Factory buyer) {
    if (buyer.gold >= totalPrice) {
      buyer.gold -= totalPrice;
      float marketCut = totalPrice * 0.02;
      market.gold += marketCut;
      seller.gold += totalPrice - marketCut;
      buyer.addResource(r,qty);
      this.buyer = buyer;
      market.completedTrades.add(this);
      //if (seller.inv.keySet().contains(r)) {
      //  seller.inv.put(r, seller.inv.get(r) + float(qty));
      //} else {
      //  seller.inv.put(r, float(qty));
      //}
    }
  }
}
