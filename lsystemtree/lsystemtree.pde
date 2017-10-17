import java.util.TreeMap;
float len = 200;
float angle = radians(25);


TreeMap<String, String> rules = new TreeMap<String, String>();
//ArrayList<String> strings = new ArrayList<String>();
String output = "F"; //start with F

void setup() {
  size(500, 700);
  //rules.put("F", "FF+[+F-F--F]-[-F+F++F]");
  rules.put("F", "FF+[+F-FF]-[-F+F[F+F]]");
  translate(width / 2, height);
  //rules.put("C", "CAC");
  background(51);
  generate();
}

void turtle() {
  len *= 0.5;
  resetMatrix();
  translate(width / 2, height);
  stroke(255);
  //len = 100;
  for (int i = 0; i < output.length(); i += 1) {
    String ch = str(output.charAt(i));

    if (ch.equals("F")) {
      line(0, 0, 0, -len);
      translate(0, -len);
      //len *= 0.5;
      //println(ch);
    } else if (ch.equals("+")) {
      rotate(angle);
    } else if (ch.equals("-")) {
      rotate(-angle);
    } else if (ch.equals("[")) {
      pushMatrix();
    } else if (ch.equals("]")) {
      popMatrix();
    }
  }
}

void generate() {

  String newOutput = "";

  for (int i = 0; i < output.length(); i += 1) {
    String ch = str(output.charAt(i));


    String replace = rules.get(ch);
    if (replace == null) {
      newOutput += ch;
    } else {
      newOutput += replace;
    }
  }
  //strings.add(output);
  output = newOutput;
  //background(51);
  turtle();
  //println(output);
}

void draw() {
  //background(0);
  fill(255);
  stroke(255);
  //int y = 10;
  //for (int i = 0; i < strings.size(); i += 1) {
  //  text(strings.get(i), 10, y);
  //  y += 10;
  //  if (y > height) {
  //    break;
  //  }
  //}
  //generate();
  //pushMatrix();
  //turtle();
  //popMatrix();
}

void mouseClicked() {
  generate();
}