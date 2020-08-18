class World {
  final int TILE_SIZE_W = 32;
  final int TILE_SIZE_H = 32;
  final int w, h;
  Cell[] cells;
  final int size;
  PImage texture;
  PImage[] textures;
  int tex_a, tex_d;
  World(int w, int h) {
    this.w = w;
    this.h = h;
    texture = loadImage("tex.png");

    size = w * h;
    cells = new Cell[size];
    init();
  }





  void init() {

    tex_a = texture.width / TILE_SIZE_W;
    tex_d = texture.height / TILE_SIZE_H;
    textures = new PImage[tex_a * tex_d];
    for (int x = 0; x < tex_a; x += 1) {

      for (int y = 0; y < tex_d; y += 1) {
        PImage img = createImage(TILE_SIZE_W, TILE_SIZE_H, ARGB);
        img.copy(texture, x*TILE_SIZE_W, y*TILE_SIZE_H, TILE_SIZE_W, TILE_SIZE_H, 0, 0, TILE_SIZE_W, TILE_SIZE_H);
        textures[y * tex_a + x] = img;
      }
    }

    for (int x = 0; x < w; x += 1) {
      for (int y = 0; y < h; y += 1) {
        Cell cell = new Cell(this, x, y);
        cell.wall = false;
        cell.faces[FACE_FLOOR] = getTextureId(0,1);
        cell.faces[FACE_NORTH] = getTextureId(1,0);
        cell.faces[FACE_EAST] = getTextureId(1,1);
        cell.faces[FACE_SOUTH] = getTextureId(1,2);
        cell.faces[FACE_WEST] = getTextureId(1,3);
        cell.faces[FACE_TOP] = getTextureId(2,0);
        cells[idx(x, y)] = cell;
        
      }
    }
  }

  int getTextureId(int x, int y ) {
    if (x >= 0 && x < tex_a && y >= 0 && y < tex_d) {
      return y * tex_a + x;
    }
    return 0;
  }


  void drawTextures(int xx, int yy, int ww, int hh) {
    int tw = ww / tex_a;
    int th = hh / tex_d;
    println(tw + "," + th);

    for (int x = 0; x < tex_a; x += 1) {
      for (int y = 0; y < tex_d; y += 1) {
        image(textures[y * tex_a + x], xx + (x * tw), yy + (y * th), tw, th);
      }
    }
  }

  Cell getCell(int x, int y) {
    if (!OOB(x, y)) {
      return cells[idx(x, y)];
    } else {
      return null;
    }
  }

  int idx(int x, int y) {
    return y * w + x;
  }

  boolean OOB(int x, int y) {
    return (x < 0 || x > w-1 || y < 0 || y > h-1);
  }
}
