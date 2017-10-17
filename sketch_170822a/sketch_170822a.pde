int crID = 0;
class Cr {
  int x, y;
  float health = 0;
  int id;

  int type;

  Cr(int type, int x, int y) {
    this.type = type;
    this.x = x;
    this.y = y;
    //crID += 1;
    //id = crID;
  }

  void draw() {
    if (type == 1) {
      stroke(255, 0, 0);
      point(x, y);
    } else {
      stroke(0, 255, 0);
      point(x, y);
    }
  }

  void move() {



    int r = (int) random(0, 6);
    int xa = 0;
    int ya = 0;
    switch (r) {
    case 0:
      ya = -1;
      break;
    case 1:
      ya = 1;
      break;
    case 2:
      xa = -1;
      break;
    case 3:
      xa = 1;
      break;
    default:
    }

    if (ya != 0 || xa != 0) {
      int newX = x + xa;
      int newY = y + ya;

      if (newX >= width || newX <= 1 || newY >= height || newY <= 1) {
      } else {


        Cr c = getAtPos(newX, newY);
        if (c == null) {
          pos[x][y] = 0;
          pos[newX][newY] = id;
          x = newX;
          y = newY;
        }
      }
    }
    
    health += random(0, 1);
    
    if (health >= 255) {
      health = 0;
      Cr c = getAtPos(x + 1, y);
      if (c == null && !outOfBounds(x+1, y)) {
        Cr cc = new Cr(2, x+1, y);
        cr.add(cc);
        cc.id = cr.size();
        pos[x+1][y] = cc.id;
      }
    }
  }
}

Cr getAtPos(int x, int y) {
  if (x >= width || x < 0 || y >= height || y < 0) return null;
  int id = pos[x][y];
  if (id == 0) {
    return null;
  } else {
    return cr.get(id-1);
  }
}

boolean outOfBounds(int x, int y) {
  if (x >= width || x <= 0 || y >= height || y <= 0) {
    return true;
  } else {
    return false;
  }
}

ArrayList<Cr> cr = new ArrayList<Cr>();
int[][] pos;
void setup() {

  size(200, 200);

  pos = new int[width][height];

  for (int i = 0; i < 50; i += 1) {
    while (true) {
      int x = (int)random(5, width-5);
      int y = (int)random(5, height-5);
      Cr check = getAtPos(x, y);
      if (check == null) {
        Cr c = new Cr(2, x, y);
        cr.add(c);
        c.id = i+1;
        pos[x][y] = c.id;
        break;
      }
    }
  }

  for (int i = 0; i < 50; i += 1) {
    while (true) {
      int x = (int)random(5, width-5);
      int y = (int)random(5, height-5);
      Cr check = getAtPos(x, y);
      if (check == null) {
        Cr c = new Cr(1, x, y);
        cr.add(c);
        c.id = i+1;
        pos[x][y] = c.id;
        break;
      }
    }
  }

  println(cr.size());
}

void draw() {
  background(0);
  for (int i = cr.size() - 1; i >= 0; i -= 1) {
    Cr c = cr.get(i);
    c.move();
    c.draw();
  }
}