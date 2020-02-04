HashMap<String, Float> letterMap = new HashMap<String, Float>();
ArrayList<String> letters;

void makeLetterMap() {
  letterMap.put("E", 1.0);
  letterMap.put("T", 0.742994395516413);
  letterMap.put("A", 0.643714971977582);
  letterMap.put("O", 0.611689351481185);
  letterMap.put("I", 0.606084867894315);
  letterMap.put("N", 0.578863090472378);
  letterMap.put("S", 0.521216973578863);
  letterMap.put("R", 0.502802241793435);
  letterMap.put("H", 0.404323458767014);
  letterMap.put("L", 0.325860688550841);
  letterMap.put("D", 0.305844675740592);
  letterMap.put("C", 0.267413931144916);
  letterMap.put("U", 0.21857485988791);
  letterMap.put("M", 0.200960768614892);
  letterMap.put("F", 0.192153722978383);
  letterMap.put("P", 0.171337069655725);
  letterMap.put("G", 0.149719775820657);
  letterMap.put("W", 0.134507606084868);
  letterMap.put("Y", 0.132906325060048);
  letterMap.put("B", 0.118494795836669);
  letterMap.put("V", 0.0840672538030424);
  letterMap.put("K", 0.0432345876701361);
  letterMap.put("X", 0.0184147317854283);
  letterMap.put("J", 0.0128102481985588);
  letterMap.put("Q", 0.00960768614891913);
  letterMap.put("Z", 0.00720576461168935);

  //
  letterMap.put("0", 0.118494795836669);
  letterMap.put("1", 0.118494795836669);
  letterMap.put("2", 0.118494795836669);
  letterMap.put("3", 0.118494795836669);
  letterMap.put("4", 0.118494795836669);
  letterMap.put("5", 0.118494795836669);
  letterMap.put("6", 0.118494795836669);
  letterMap.put("7", 0.118494795836669);
  letterMap.put("8", 0.118494795836669);
  letterMap.put("9", 0.118494795836669);
  letters = new ArrayList<String>(letterMap.keySet());
}

String getLetter() {
  String k = null;

  while (k == null) {
    k = letters.get(floor(random(letters.size())));
    float n = random(1);
    float v = letterMap.get(k);
    if (n > v) {
      k = null;
    }
  }


  return k;
}

class Document {
  PVector pos, dims;

  PGraphics img;
  int textWidth = 0;
  int charWidth = 0;


  Document(float w) {
    dims = new PVector(w, w*sqrt(2));
    generate();
  }

  void generate() {
    img = createGraphics(floor(dims.x), floor(dims.y));

    img.beginDraw();

    img.background(PAPER_BG);

    img.noFill();
    img.stroke(PAPER_BORDER);
    img.strokeWeight(4);
    img.rect(2, 2, dims.x-4, dims.y-4);
    img.textFont(font_ibm);
    charWidth = (int)img.textWidth("W");
    textWidth = (img.width - 25) / charWidth;
    img.fill(51);
    int lineCount = 0;
    for (int y = 12; y < dims.y - 20; y += 7) {
      lineCount += 1;
      //if (random(1) < 0.05) continue;
      
      if (lineCount <= 5) {
        String line = "";
        for (int x = (int)dims.x - 20; x >= img.width / 2; x -= charWidth) {

          //img.text(getLetter(), x, y);
          line += getLetter();

          if (random(1) < 0.05) {
            if (random(1) < 0.10) {
              continue;
            }
            break;
          }
        }
        Padder.setStrings(line);
        Padder.setWidths(textWidth);
        Padder.setTotalWidth(textWidth);
        Padder.setOptions(true);
        img.text(Padder.pad(), 20,y);
      } else if (lineCount == 6) {
        Padder.reset();
        Padder.setStrings(".............................................");
        Padder.setWidths(textWidth);
        Padder.setTotalWidth(textWidth);
        Padder.setOptions(false);
        img.text(Padder.pad(), 20,y);
        
        
      } else {
        Padder.reset();
        
        String name = "";
        for (int i = 0; i < (textWidth / 4); i += 1) {
          name += getLetter();
          if (name.length() > 5) {
            if (random(1) < 0.2) {
              break;
            }
          }
        }
        int qty = floor(random(1,20));
        float price = random(6,12);
        float totalValue = (float) qty * price;
        Padder.setStrings(name, str(qty), nfc(price, 2), nfc(totalValue,2));
        Padder.setWidths(textWidth / 4, textWidth / 4, textWidth / 4, textWidth / 4);
        Padder.setTotalWidth(textWidth);
        Padder.setOptions(false,true,true,true);
        img.text(Padder.pad(), 20,y);        
        
      }
    }


    img.endDraw();
  }

  void draw() {
    image(img, 0, 0);
  }
}
