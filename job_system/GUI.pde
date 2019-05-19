class GUIManager {
  ArrayList<Button> buttons = new ArrayList<Button>(); 
  
  void addButton(String text, float x, float y) {
    buttons.add(new Button(text,x,y,GUI_WIDTH-5,20));
  }
  
  void draw() {
    for (Button button : buttons) {
      button.draw();
    }
  }
  
}

class Button {
  PVector pos, dims;
  Clickable click;
  String text;
  Button(String text, float x, float y, float w, float h) {
    this.text = text;
    click = new Clickable(x,y,w,h);
    pos = new PVector(x,y);
    dims = new PVector(w,h);
  }
  
  void draw() {
    GUI.fill(51);
    GUI.stroke(100);
    GUI.rect(pos.x, pos.y, dims.x, dims.y);
    GUI.fill(255);
    GUI.text(text, pos.x + 5, pos.y + 10);
  }
  
  
  
  
  
}
