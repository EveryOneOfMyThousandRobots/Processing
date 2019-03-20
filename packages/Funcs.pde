void findNeighbours() {
  highestCost = 0;
  for (int i = 0; i < nodes.size(); i += 1) {
    Node from = nodes.get(i);
    float x = from.pos.x - (MAX_DIST);
    float y = from.pos.y - (MAX_DIST);

    ArrayList<Node> neighbours = getPoints(x, y, MAX_DIST*2, MAX_DIST*2);
    if (from.type == NODE_TYPE.SHOP) {
      //println("Shop possible neighbours: " + neighbours.size());
      //stroke(255, 0, 0);
      //noFill();
      //rect(x, y, MAX_DIST*2, MAX_DIST*2);
    }
    for (int j = 0; j < neighbours.size(); j += 1) {



      Node to = neighbours.get(j);
      //println("from.type(" + from.type + ") => to.type(" + to.type + ")");
      if (from.equals(to)) continue;
      if (PVector.dist(from.pos, to.pos) <= MAX_DIST) {


        if  (from.type == NODE_TYPE.CUSTOMER) {
          //do nothing
        } else if (from.type == NODE_TYPE.SHOP) {
          //println("looking at shop " + to.type);
          if (to.type == NODE_TYPE.TRANSPORT) {
            //println("adding " + to.toString() + " to " + from.toString());
            from.addNeighbour(to);
          }
        } else if (from.type == NODE_TYPE.TRANSPORT) {
          if (to.type == NODE_TYPE.CUSTOMER || to.type == NODE_TYPE.TRANSPORT) {
            from.addNeighbour(to);
          }
        }
      }
    }
  }
}



enum NODE_TYPE {
  CUSTOMER, SHOP, TRANSPORT;
}


boolean okToAdd(Node from, Node to) {

  for (Conn c : connections) {
    Line2D.Float l = getLineBetween(from.pos, to.pos);
    if (c.line.intersectsLine(l)) {
      return false;
    }
  }

  return true;
}


Node getRandomNode(NODE_TYPE type) {
  Node n = null;

  while (n == null) {
    n = getRandomNode();
    if (n.type != type) {
      n = null;
    }
  }

  return n;
}
Node getRandomNode() {
  return nodes.get(floor(random(nodes.size())));
}


Line2D.Float getLineBetween(PVector A, PVector B) {

  Line2D.Float line = new Line2D.Float();

  PVector L = PVector.sub(B, A);
  float dist = PVector.dist(A, B);
  L.normalize();
  PVector Lp = PVector.fromAngle(L.heading());
  Lp.mult(dist * 0.02);
  PVector Lpp = PVector.add(A, Lp);


  PVector N = PVector.sub(A, B);
  N.normalize();
  PVector Np = PVector.fromAngle(N.heading());
  Np.mult(dist * 0.02);
  PVector Npp = PVector.add(B, Np);
  line.setLine(Lpp.x, Lpp.y, Npp.x, Npp.y);


  return line;
}
void createCarton() {
  int attempts = 0;
  Node customer = getRandomNode(NODE_TYPE.CUSTOMER);
  while (attempts < NUM_SHOP_NODES * 2) {
    Node shop = getRandomNode(NODE_TYPE.SHOP);
    if (shop.cartons.size() < NODE_LIMIT) {
      cartons.add( new Carton(shop, customer));
      break;
    }
    attempts += 1;
  }
}

void addNodes(NODE_TYPE type, int num) {
  int added = 0;
  int attempts = 0;
  while (added < num && attempts < 1000) {
    attempts += 1;
    float x = random(width);
    float y = random(height);
    ArrayList<Node> pts = getPointsInRadius(x, y, MIN_DIST);


    if (pts.size() == 0) {
      Node n = new Node(x, y, type);
      nodes.add(n);
      quad.addPoint(n);
      added += 1;

      switch (type) {
      case CUSTOMER:
        customers.add(n);
        break;
      case TRANSPORT:
        transport.add(n);
        break;
      case SHOP:
        shops.add(n);
        break;
      }
    }
  }
}
