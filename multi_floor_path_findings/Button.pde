import java.util.Queue;
import java.util.LinkedList;
void makeButton(String name, String text, float x, float y ){
  buttons.add(new Button(x,y,text,name));
}
ArrayList<Button> buttons = new ArrayList<Button>();
Queue<String> eventQueue = new LinkedList<String>();
class Button {
  String name;
  String text;
  PVector pos;
  boolean over = false;
  
  Button (float x, float y, String text, String name) {
    this.pos = new PVector(x,y);
    this.name = name;
    this.text= text;
  }
  
  void draw() {
    stroke(51);
    if (over) {
      fill(128);
    } else {
      fill(100);
    }
    
    rect(pos.x, pos.y, TILE_W, TILE_H);
    fill(255);
    textAlign(CENTER,CENTER);
    text(text, pos.x + (TILE_W / 2), pos.y + (TILE_H / 2));
    
  }
  
  boolean mouseOver(int x, int y) {
    return (x >= pos.x && x < pos.x + TILE_W && y >= pos.y && y < pos.y + TILE_H); 
    
    
  }
  
  void pressed() {
    eventQueue.add(name);
  }
}

void checkButtons() {
  for (Button button : buttons) {
    if (button.mouseOver(mouseX, mouseY)) {
      button.over = true;
      if (mousePressed && mouseButton == LEFT) {
        button.pressed();
      }
    } else {
      button.over = false;
    }
  }
}
