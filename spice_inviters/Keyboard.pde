final int VK_SPACE = 32;

void keyReleased() {
  //println(keyCode);
  switch (keyCode) {
  case UP:
    player.thrusting = false;
    break;
  case DOWN:
    break;
  case LEFT:
    player.rotating = 0;
    break;
  case RIGHT:
    player.rotating = 0;
    break;
  case VK_SPACE:
    player.shoot();
    break;
  }
}


void keyPressed() {
  //println(keyCode);
  switch (keyCode) {
  case UP:
    player.thrusting = true;
    break;
  case DOWN:
    break;
  case LEFT:
    player.rotating = -1;
    break;
  case RIGHT:
    player.rotating = 1;
    break;
  }
}
