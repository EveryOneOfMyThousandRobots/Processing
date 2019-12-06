import controlP5.*;


ControlP5 gui;

void guiSetup() {
  gui.addButton("BtnBuildRoom").setPosition(GUI_X, TILE_H * 2).updateSize().setLabel("ROOM");
  gui.addButton("BtnBuildStairs").setPosition(GUI_X, TILE_H * 3).updateSize().setLabel("STAIRS");
  
  gui.addSlider("sldBuilders")
    .setPosition(GUI_X, TILE_H * 4)
    .setSize(TILE_W*2,(int)(TILE_H*0.6))
    .setRange(0,5)
    .setNumberOfTickMarks(6)
    .setValue(0)
    .setLabel("Num Builders");
    
  gui.getController("sldBuilders").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM).setPaddingX(2);
  gui.getController("sldBuilders").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP).setPaddingX(2);
  
}

public void controlEvent(ControlEvent theEvent) {
 // println(theEvent.getController().getName());
 
  //n = 0;
}

public void sldBuilders(float value) {
  println("num builders = " + floor(value));
}

public void BtnBuildRoom() {
  println("build Room");
  
  if (selectedTile != null) {
    selectedTile.changeType(TT.ROOM);
  }
}

public void BtnBuildStairs() {
  println("build stairs");
}
