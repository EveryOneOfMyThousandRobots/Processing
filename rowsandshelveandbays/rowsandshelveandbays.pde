

class Area {
  ArrayList<Row> rows = new ArrayList<Row>();

  Area() {
    for (int i = 0; i < 4; i++) {
      Row row = new Row(i, this);
      rows.add(row);
    }
  }

  void draw() {
    fill(255);
    stroke(0);
    rect(0, 0, width, height);
    for (Row row : rows) {
      row.draw();
    }
  }
}

class Row {
  ArrayList<Bay> bays = new ArrayList<Bay>();
  int rowId;
  Area area;
  PVector pos = null, size = null;
  Row(int rowId, Area area) {
    this.rowId = rowId;
    this.area = area;
    for (int i = 0; i < 10; i++) {
      Bay bay = new Bay(i, this);
      bays.add(bay);
    }
  }

  void draw() {
    float countRows = this.area.rows.size();
    float rowWidth = width / countRows;
    float rowHeight = height;

    float x = rowWidth * rowId;
    float y = 0;
    fill(0, 0, 0, 0);
    stroke(0);
    if (pos == null) {
      pos = new PVector(x + 2, y + 2);
      size = new PVector(rowWidth - 4, rowHeight - 4);
    }    

    rect(pos.x, pos.y, size.x, size.y);
    
    for (Bay bay : bays) {
      bay.draw();
    }
    
  }
}

class Bay {
  ArrayList<Shelf> shelves = new ArrayList<Shelf>();
  int bayId;
  Row row;

  PVector pos = null, size =null;
  Bay(int bayId, Row row) {
    this.row = row;
    this.bayId = bayId;
    for (int i = 0; i < 1; i++) {
      Shelf shelf = new Shelf(i, this);
      shelves.add(shelf);
    }
  }

  void draw() {
    float countBays = this.row.bays.size();
    float rowWidth = this.row.size.x;
    float rowHeight = this.row.size.y;

    float bayWidth = rowWidth;
    float bayHeight = ((rowHeight) / countBays);

    float x = this.row.pos.x;
    float y = this.row.pos.y + (bayHeight * bayId);

    if (pos == null) {
      pos = new PVector(x + 1, y + 1);
      size = new PVector(bayWidth - 2, bayHeight - 2);
    }
    
    rect(pos.x, pos.y, size.x, size.y);

    for (Shelf shelf : shelves) {
      shelf.draw();
    }
  }
}

class Shelf {
  ArrayList<Bin> bins = new ArrayList<Bin>();
  int shelfId;
  Bay bay;

  PVector pos = null, size = null;
  Shelf(int shelfId, Bay bay) {
    this.shelfId = shelfId;
    this.bay = bay;
    for (int i = 0; i < 7; i++) {
      Bin bin = new Bin(i, this);
      bins.add(bin);
    }
  }

  void draw() {
    float countShelves = this.bay.shelves.size();
    float bayWidth = this.bay.size.x;
    float bayHeight = this.bay.size.y;

    float shelfWidth = (bayWidth / countShelves);
    float shelfHeight = bayHeight;

    float x = (this.bay.pos.x) + (shelfId * shelfWidth);
    float y = this.bay.pos.y;

    if (pos == null) {
      pos = new PVector(x + 2, y + 2);
      size = new PVector(shelfWidth - 6, shelfHeight - 6);
    }

    //fill(0, 0, 255);
    rect(pos.x, pos.y, size.x, size.y);
    
    for (Bin bin : bins) {
    //  bin.draw();
    }
  }
}

class Bin {
  int binId;
  Shelf shelf;
  PVector pos, size;
  Bin(int binId, Shelf shelf) {
    this.binId = binId;
    this.shelf = shelf;
  }

  void draw() {
    float countBins = this.shelf.bins.size();
    float shelfWidth = shelf.size.x;
    float shelfHeight = shelf.size.y;

    float binWidth = shelfWidth;
    float binHeight = (shelfHeight / countBins);

    float x = this.shelf.pos.x + 1;
    float y = this.shelf.pos.y + (binHeight * binId);

  //  fill(255);
    rect(x + 1, y + 1, binWidth - 2, binHeight - 2);
  }
}

Area area;
void setup () {
  size(800, 600);
  area = new Area();
  noLoop();
}

void draw() {
  background(0);
  area.draw();
}