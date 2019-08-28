
void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}
void setup() {
  
  boolean ok = false;

  while (!ok) {
    ok = true;
    nodes.clear();
    customers.clear();
    shops.clear();
    transport.clear();
    connections.clear();
    trucks.clear();
    
    //MAX_DIST = width / 4;
    //MIN_DIST = width / 10;
    quad = new QuadTree(0, 0, width, height);

    addNodes(NODE_TYPE.CUSTOMER, NUM_CUST_NODES);
    addNodes(NODE_TYPE.SHOP, NUM_SHOP_NODES);
    addNodes(NODE_TYPE.TRANSPORT, NUM_TRANSPORT_NODES);


    //noLoop();
    for (Conn c : connections) {
      if (c.from.type == NODE_TYPE.SHOP) {
        //println(c.toString());
      }
    }


    findNeighbours();
    //testPath = new PathFinder(testFrom, testTo);]


    for (Node shop : shops) {
      for (Node cust : customers) {
        PathFinder pf = new PathFinder(shop, cust);
        if (!pf.foundPath) {
          println("notFound");
          ok = false;
        }
      }
    }
  }

  makeTrucks();
}

void draw() {
  long timeNow = millis();
  delta = timeNow - timeLast;
  fps = 1000.0f / delta;
  timeLast = timeNow;
  elapsed += delta;
  if (elapsed >= 1000) {
    displayDelta = int(delta);
    displayFps = fps;
    elapsed = 0;
  }
  background(0);

  if (cartons.size() < MAX_CARTONS && random(1) < 0.2) {
    createCarton();
    
  }

  for (Conn c : connections) {
    //println(c);
    c.draw();
  }

  for (Node n : nodes) {
    n.update();
    n.draw();
  }

  for (int i = cartons.size() - 1; i >= 0; i -=1 ) {
    Carton c = cartons.get(i);
    c.update();
    c.draw();

    if (c.arrived) {
      cartons.remove(i);
    }
  }

  for (Truck t : trucks) {
    t.update();
    t.draw();
  }
  noStroke();
  fill(255);
  String debug = "cartons: " + cartons.size();
  debug += "\ntrucks: " + trucks.size();
  debug += "\nnodes: " + nodes.size();
  debug += "\ndelta: " + displayDelta;
  debug += "\nfps: " + nf(displayFps,2,1);
  //debug += "\ntrucks: " + trucks.size();
  //debug += "\ntrucks: " + trucks.size();
  //debug += "\ntrucks: " + trucks.size();
  fill(0, 150);
  rectMode(CORNER);
  rect(0,0,width / 4, height);
  fill(255);
  text(debug, 10, 10);
  //float w = width / 8;
  //float w2 = w / 2;
  //ArrayList<Node> pnts = getPointsInRadius(mouseX,mouseY,w);

  //noFill();
  //stroke(255,0,0);
  //ellipse(mouseX, mouseY, w*2, w*2);
  //rect(mouseX, mouseY, w * 2, w * 2);
  //text(pnts.size(), mouseX + 10, mouseY);

  //testPath.draw();
  //quad.draw();
}

void mousePressed() {
  //cartons.add(new Carton());
}
