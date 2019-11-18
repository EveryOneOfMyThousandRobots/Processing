PVector axis = new PVector(1, -1); //<>//


ArrayList<Shape> shapes = new ArrayList<Shape>();

void setup() {
  size(600, 600);
}
color shapeColor = color(255);
void update() {
  if (shapes.size() >= 2) {
    Shape A = shapes.get(0);
    Shape B = shapes.get(1);

    ArrayList<PVector> A_norm = A.getNorm();
    ArrayList<PVector> B_norm = B.getNorm();

    ArrayList<PVector> A_vecs = A.copyPoints();
    ArrayList<PVector> B_vecs = B.copyPoints();

    boolean isSep = false;

    for (int i = 0; i < A_norm.size(); i += 1) {
      MinMax box1 = getMinMax(A_vecs, A_norm.get(i));
      MinMax box2 = getMinMax(B_vecs, A_norm.get(i));
      println(box1 + " " + box2);
      isSep = box1.max_proj_box < box2.min_proj_box || box2.max_proj_box < box1.min_proj_box;

      if (isSep) break;
    }

    if (!isSep) {
      for (int i = 0; i < B_norm.size(); i += 1) {
        MinMax box1 = getMinMax(A_vecs, B_norm.get(i));
        MinMax box2 = getMinMax(B_vecs, B_norm.get(i));

        isSep = box1.max_proj_box < box2.min_proj_box || box2.max_proj_box < box1.min_proj_box;

        if (isSep) break;
      }
    }

    if (!isSep) {
      shapeColor = color(255, 0, 0);
    } else {
      shapeColor = color(255);
    }
  }
}

void draw() {
  background(0);
  for (Shape shape : shapes) {
    shape.update();
    shape.draw();
  }
  update();
}

Shape selected = null;


void keyReleased() {
  if (key == 'R' || key == 'r') {
    if (selected != null) {
      selected.addAngle(0.2);
    }
  }
}
void mouseDragged() {
  if (mouseButton == LEFT) {
    if (selected != null) {
      selected.pos.set(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    selected = null;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (Shape s : shapes) {
      if (s.pointIsInBounds(mouseX, mouseY)) {
        selected = s;
        break;
      }
    }
  } else if (mouseButton == RIGHT) {
    Shape shape = new Shape(mouseX, mouseY);
    shape.makeSquare(width / 8);
    shapes.add(shape);
  }
}
