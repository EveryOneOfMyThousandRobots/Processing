class Map {
  final int EXCLUSION_Z = 0xffff00;
  final int CHEST = 0xff0000;
  final int WALL = 0x0;
  final int ROBOT = 0x404040;
  PImage img;
  
  ArrayList<Node> walls = new ArrayList<Node>();

  Map(String p) {
    img = loadImage(p);
  }
  
  void drawWalls() {
    GAME_WINDOW.noStroke();
    GAME_WINDOW.fill(0);
    for (Node n : walls) {
      GAME_WINDOW.rect(n.cornerPos.x, n.cornerPos.y, GRID_SIZE, GRID_SIZE);
    }
  }

  void generate() {
    img.loadPixels();
    if (nodes.length == img.width && nodes[0].length == img.height) {
    } else {
      println("could not parse map");
      exit();
    }
    //exclu: ffff00
    //chest: FF0000
    //wall : 000000
    //robot: 404040
    for (int x = 0; x < img.width; x += 1) {
      for (int y = 0; y < img.height; y += 1) {
        Node n = getNode(x, y);
        int c = img.get(x, y) & 0xffffff;

        switch (c) {
        case EXCLUSION_Z:
          n.exclusionZone = true;
          break;
        case CHEST:
          n.chest = true;
          break;
        case WALL:
          n.wall = true;
          break;
        case ROBOT:
          n.robot_start = true;
          break;
        }
      }
    }
  }
}
