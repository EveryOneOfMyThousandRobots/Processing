ArrayList<String> rslts = new ArrayList<String>();
long iterations = 0;
class Chrs {
  int[] chrs = new int[6];

  Chrs() {
    
  }

  String safe = "0123456789ABCDEFGHJKLMPQRSTVWXYZ";

  String toString() {
    String s = "\t";

    for (int i = chrs.length-1; i >= 0; i -= 1) {

      s += safe.charAt(chrs[i]);
    }

    return s;
  }

  String toString2() {
    String s = "";

    for (int i = chrs.length-1; i >= 0; i -= 1) {
      s += "\t " + chrs[i];
    }

    return s;
  }

  void update() {
    iterations += 1;
    int i = 0;
    while (true) {
      chrs[i] += 1;
      if (chrs[i] > 31) {
        chrs[i] = 0;
        i += 1;
        if (i >= chrs.length) {
          i = 0;
          for(int ii = 0; ii < chrs.length; ii += 1) {
            chrs[ii] = 0;
          }
        }
      } else {
        break;
      }
    }
  }
}

Chrs chr;
int ii = 0;
void setup() {
  chr = new Chrs();
  size(500, 500);
  frameRate(1000);

  for (int i = 0; i < 32; i += 1) {
    rslts.add("00000000");
  }
}


void draw() {
  chr.update();

  rslts.set(ii, nf(iterations) + ": " + chr.toString()+ "\t" + chr.toString2());
  ii += 1;
  if (ii >= rslts.size()) {
    ii = 0;
  }

  if (frameCount % 100 == 0 ) {
    background(0);
    
    int y = 41;
    for (String s : rslts) {
      text(s, 10, y);
      y += 11;
    }
  }
}