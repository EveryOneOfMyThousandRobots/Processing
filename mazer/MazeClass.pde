class Maze {
  PImage img;
  
  Maze(PImage img) {
    this.img = img;
    
    //find start and end
    for(int x = 0; x < img.width; x += 1) {
      for (int y = 0; y < img.height; y += 1) {
        if (x == 0 || y == 0 || x == img.width - 1 || y == height-1) {
          
        }
      }
    }
  }
}