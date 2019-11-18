final int CAM_SPEED = 5;

void keyPressed() {
  if (keyCode == 'P') {
    testPath();
  }
  
  
  if (keyCode == 'W') {
    playYOffset -= CAM_SPEED;
  }

  if (keyCode == 'S') {
    playYOffset += CAM_SPEED;
  }

  if (playYOffset < 0) {
    playYOffset = 0;
  } else if (playYOffset > GAME_AREA_SIZE_H - VIEWPORT_H) {
    playYOffset = GAME_AREA_SIZE_H - VIEWPORT_H;
  }

  if (keyCode == 'A') {
    playXOffset -= CAM_SPEED;
  }

  if (keyCode == 'D') {
    playXOffset += CAM_SPEED;
  }

  if (playXOffset < 0) {
    playXOffset = 0;
  } else if (playXOffset > GAME_AREA_SIZE_W - VIEWPORT_W) {
    playXOffset = GAME_AREA_SIZE_W - VIEWPORT_W;
  }
}

int screenToWorldXI(float x) {
  return floor(screenToWorldX(x));
}

int screenToWorldYI(float y) {
  return floor(screenToWorldY(y));
}


float screenToWorldX(float x) {

  return x - PLAY_X + playXOffset;
}

float screenToWorldY(float y) {

  return y - PLAY_Y + playYOffset;
}


boolean mouseOverGUI() {
  return mouseX >= GUI_X && mouseX < GUI_X + GUI_W && mouseY >= GUI_Y && mouseY < GUI_Y + GUI_H;
}

boolean mouseOverPlay() {
  return mouseX >= PLAY_X && mouseX < PLAY_X + VIEWPORT_W && mouseY >= PLAY_Y && mouseY < PLAY_Y + VIEWPORT_H;
}

void mouseReleased() {
  if (mouseOverPlay()) {
    if (mouseButton == LEFT || mouseButton == RIGHT) {
      if (selectedTile != null) {
        selectedTile = null;
      }
    }

    if (mouseButton == LEFT) {
      selectedTile = getTileAtScreenCoord(mouseX, mouseY);
    }
  }
}
