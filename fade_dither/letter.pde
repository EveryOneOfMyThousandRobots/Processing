class Letter {

  String s;
  PGraphics letter_image;
  boolean[][] map;

  Letter(String s) {
    this.s = s;
    letter_image = createGraphics(10, 14);
    map = new boolean[10][14];
    letter_image.beginDraw();

    letter_image.textFont(font_small);
    letter_image.textAlign(CENTER, CENTER);
    letter_image.fill(255);
    letter_image.background(0);
    letter_image.text(s, letter_image.width/2, letter_image.height/2);
    letter_image.loadPixels();

    for (int x = 0; x < letter_image.width; x += 1) {
      for (int y = 0; y < letter_image.height; y += 1) {
        int idx = y * letter_image.width + x;

        float b = brightness(letter_image.pixels[idx]);

        if (b > 128) {
          map[x][y] = true;
        }
      }
    }
    letter_image.endDraw();
  }

  void draw3d(PGraphics canvas, float x, float y, float r, float size) {
    canvas.pushMatrix();

    canvas.translate(x, y-(size/2));
    canvas.rotateY(r);
    for (int xx = 0; xx < letter_image.width; xx += 1) {
      for (int yy = 0; yy < letter_image.height; yy += 1) {
        if (map[xx][yy]) {
          canvas.pushMatrix();
          canvas.translate((xx * size)-size/2, (yy * size)-size/2);
          canvas.fill(255);
          canvas.stroke(128);
          canvas.box(size, size, size*5);
          canvas.popMatrix();
        }
      }
    }

    canvas.popMatrix();
  }
}

void makeLetters() {
  for (char s = 65; s < 65 + 26; s += 1) {
    String cs  = str(s);
    getLetter(cs);
  }
}

void drawLetters() {
  int x = 0;
  int y = 0;
  for (String s : letters.keySet()) {
    Letter l = letters.get(s);
    image(l.letter_image, x, y);
    x += l.letter_image.width;
    if (x + l.letter_image.width > width) {
      x = 0;
      y += l.letter_image.height;
    }
  }
}

Letter getLetter(String s) {
  if (s.length() == 1) {
    if (letters.containsKey(s)) {
      return letters.get(s);
    } else {
      Letter letter = new Letter(s);
      letters.put(s, letter);
      return letter;
    }
  } else {
    return null;
  }
}

HashMap<String, Letter> letters = new HashMap<String, Letter>();
