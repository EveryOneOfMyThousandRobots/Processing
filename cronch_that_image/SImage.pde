class SImage {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  final double STDIV;
  final double STDIV_SQRT;
  final CHANNEL channel;
  int tileWidth = 0;
  int tileHeight = 0;
  int tileFactor = 10;
  int tileMinWidth = 2;
  int tileMinHeight = 2;
  PImage img;
  int xoff, yoff;
  String path;
  String fileName;
  String saveAs;
  boolean saved = false;


  PGraphics grp;
  float tileChance = random(0.005);


  SImage(String path, CHANNEL channel) {
    File f = new File(path);
    fileName = f.getName();
    saveAs = fileName.substring(0, fileName.lastIndexOf(".")) + channel;
    println(saveAs);
    this.path = path;
    this.channel = channel;
    img = null;
    try {
      img = loadImage(path);
    } 
    catch(Exception e) {
      println("Exception: " + e.getMessage());
      exit();
    }
    if (img != null) {
      tileWidth = img.width/tileFactor;

      tileHeight = img.height/tileFactor;

      STDIV = getStdi(img, 0, 0, img.width, img.height, channel);
      STDIV_SQRT = (double)sqrt((float)STDIV);
      //println("global stdiv = " + nfc((float)glo_STDI, 4));
      //tiles.clear();

      img = bestFit(img, tileFactor);
      xoff = (width / 2) - (img.width / 2);
      yoff = (height / 2) - (img.height / 2);

      //if (frameCount % 2 == 0) {


      //image(img, 0,0 );
      //starter = img;
      //init();
      //background(0);


      buildTiles();
      render();
    } else {
      STDIV = STDIV_SQRT = 0;
    }
  }

  void output() {
    if (!saved) {
      //grp.beginDraw();
      saved= true;
      grp.save("output\\" + saveAs + ".jpg");
    }
    //grp.endDraw();
  }

  void render() {
    grp = createGraphics(img.width, img.height);
    grp.beginDraw();
    grp.background(0);
    for (int i = 0; i < tiles.size(); i += 1) {
      Tile t = tiles.get(i);
      if (t.children) {
        continue;
      }
      Tile s = null;
      float tt = ((t.pos.y + t.pos.x) / (grp.height + grp.width)) / 100.0;
      if (random(1) < tt) {
        s = getRandom(this, t);
      }
      if (s != null) {
        s.draw(t);
      } else {
        t.draw(t);
      }
    }

    for (Tile t : tiles) {
      t.drawOffset();
    }

    grp.endDraw();
    output();
  }

  void draw() {
    background(0);
    image(grp, xoff, yoff);
    noFill();
    stroke(255);
    rect(xoff, yoff, img.width, img.height);
    fill(255);
    text("image: " + path, 12, 12);
    text("stdiv: " + STDIV, 12, 24);
    text("index: " + imageIndex, 12, 36);
  }

  void buildTiles() {
    for (int x = 0; x < width; x += tileWidth) {
      for (int y = 0; y < height; y += tileHeight) {
        Tile t = new Tile(this, x, y, tileWidth, tileHeight);
        if (!t.children) {
          tiles.add(t);
        }
        //if (tiles.size() % 10 == 0) {
        //  println(tiles.size());
        //}
      }
    }
  }
}
