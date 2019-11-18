Blob[] blobs;
int numBlobs = 5;
int gloBlobId = 0;



class Blob {
  int blobId;
  SVector pos;
  SVector tgt;
  SVector tgtNorm;
  SVector tgtLine;
  int size = 20;
  boolean moving = false;
  Blob followBlob = null;
  boolean followMe = false;

  Blob () {
    blobId = ++gloBlobId;

    float x = (int)random(size, width - size);
    float y = (int)random(size, height - size);
    pos = new SVector(x, y);
    tgt = new SVector(x, y);
    tgtNorm = new SVector(0, 0);
    tgtLine = new SVector(0, 0);
  }
  void draw() {

    ellipse(pos.x, pos.y, size, size);
    if (moving) {
      line(pos.x, pos.y, tgtLine.x, tgtLine.y);
    }
  }

  void move() {
    int rnd = (int) random(1, 100);
    if (!followMe) {
      if (followBlob == null) {
        if (rnd < 5) {
          while (followBlob == null ) {
            int getBlob = (int) random(0, blobs.length);
            Blob b = blobs[getBlob];
            if (b.followMe) {
              followBlob = b;
              moving = true;
              tgt.x = followBlob.pos.x;
              tgt.y = followBlob.pos.y;
            }
          }
        }
      }
    } else if (!moving) {
      tgt.x = random(1, width);
      tgt.y = random(1, height);
      moving = true;
    }
    if (followMe) {
      if (pos.x + tgt.x >= width || pos.x + tgt.x <= size ) {
        tgt.x *= -1;
      } 
      if (pos.y + tgt.y >= height || pos.y + tgt.y <= size ) {
        tgt.y *= -1;
      }
    }
    if (followBlob != null) {
      tgt.x = followBlob.pos.x;
      tgt.y = followBlob.pos.y;
    }

    if (moving) {
      tgtNorm.x = tgt.x;
      tgtNorm.y = tgt.y;
      tgtNorm.normalise();
      tgtLine.x = tgt.x;
      tgtLine.y = tgt.y;
     
      pos.add(tgtNorm);
    }
  }

  void print() {
    println("Id: " + blobId+ "\tme:" + pos.x + "," + pos.y);
    println("\ttarget:" + tgt.x + "," + tgt.y);
    println("tgtVector: " + tgtNorm.x + "," + tgtNorm.y);
  }
}

void setup() {
  frameRate(30);
  size(400, 400);
  blobs = new Blob[numBlobs];


  for (int i = 0; i < blobs.length; i++) {
    Blob b = new Blob();
    blobs[i] = b;
  }
  blobs[0].followMe = true;
}

void draw() {
  background(255);
  boolean printDetails = false;
  if (frameCount % 25 == 0) {
    printDetails = true;
  }

  for (Blob b : blobs) {
    b.move();
    b.draw();
    if (printDetails) {
      b.print();
    }
  }
}

