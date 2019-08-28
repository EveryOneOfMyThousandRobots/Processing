//alphabet F+-[]
float len;// = 100;
float startingLen = 100;
String axiom = "F";
String sentence = axiom;
ArrayList<Rule> rules = new ArrayList<Rule>();
float angle;
float mainAngle;
float rot;
void setup() {
  size(500, 500);
  angle = radians(22.5);
  mainAngle = angle;
  rules.add(new Rule("F", "FF+[+F-F-F]-[-F+F+F]"));
  //rules.add(new Rule("B", "A"));
  len = startingLen;
}

void draw() {
  background(51);
  //text(sentence, 10, 10);
  resetMatrix();
  translate(width / 2, height);
  stroke(255);
  turtle();
  rot = (rot + radians(1)) % TWO_PI;
  angle = mainAngle + radians(sin(rot))*2;
}

void turtle() {
  
  
  for (int i = 0; i < sentence.length(); i += 1) {
    String curr = str(sentence.charAt(i));
    
    switch (curr) {
    case "F":
      line(0,0,0,-len);
      translate(0,-len);
      break;
    case "+":
      rotate(angle);
      break;
    case "-":
      rotate(-angle);
      break;
    case "[":
      pushMatrix();
      break;
    case "]":
      popMatrix();
      break;
    }
  }
}

void mouseReleased() {
  generate();
}
