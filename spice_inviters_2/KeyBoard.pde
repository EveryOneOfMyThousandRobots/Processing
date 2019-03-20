import  java.awt.event.KeyEvent;
//final int VK_SPACE = 32;
String kp = "";
String kr = "";
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
  case KeyEvent.VK_SPACE:
    if (paused) {
      paused = false;
    } else {
      player.shooting = true;
    }
    break;
  case KeyEvent.VK_F5:
    debug = !debug;
    break;
  case KeyEvent.VK_P:
    paused = !paused;
    break;
  }
}

String append(String s, String a) {
  if (s.length() == 0) {
    s = a;
  } else {
    s += " " + a;
  }

  return s;
}
void keyPressed() {
  kp = "";
  //println(keyCode);
  if (keyCode == UP) {
    player.thrusting = true;
    kp = append(kp, "UP");
  }

  if (keyCode == DOWN) {
    kp = append(kp, "DOWN");
  }

  if (keyCode == LEFT) {
    player.rotating = -1;
    kp = append(kp, "LEFT");
  }

  if (keyCode == RIGHT) {
    player.rotating = 1;
    kp = append(kp, "RIGHT");
  }

  if (keyCode == KeyEvent.VK_SPACE) {
    player.shooting = true;
    kp = append(kp, "SPC");
  }
  //switch (keyCode) {
  //case UP:
  //  player.thrusting = true;
  //  kp += "UP ";
  //  break;
  //case DOWN:
  //  kp += "DOWN ";
  //  break;
  //case LEFT:
  //  kp += "LEFT ";
  //  player.rotating = -1;
  //  break;
  //case RIGHT:
  //  kp += "RIGHT ";
  //  player.rotating = 1;
  //  break;
  //case VK_SPACE:
  //  player.shooting = true;    
  //  break;
  //}
}
