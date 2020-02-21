import java.util.Arrays;
void controlEvent(CallbackEvent evt) {
  Controller c = evt.getController();

  // if (theEvent.getController().equals(s2)) {
  switch(evt.getAction()) {
    case(ControlP5.ACTION_ENTER): 
    //println("Action:ENTER");
    break;
    case(ControlP5.ACTION_LEAVE): 
    //println("Action:LEAVE");
    break;
    case(ControlP5.ACTION_PRESSED): 
    //println("Action:PRESSED " + c.getName());
    String cName = c.getName();
    String cLabel = c.getLabel();

    if (cName.startsWith("BTN_FX_")) {
      listEffectChain.addItems(Arrays.asList(cLabel));
    } else {
      switch(cName) {
      case "BTN_C_LOAD_IMAGE":
        base = loadImage(getImageFile());
        break;
      case "BTN_C_RESET":
        base = null;
        output = null;
        frames = null;
        listEffectChain.clear();
        break;
      case "BTN_C_PROCESS":
        createOutputImage();
        break;
      }
    }



    break;
    case(ControlP5.ACTION_RELEASED): 
    //println("Action:RELEASED");
    break;
    case(ControlP5.ACTION_RELEASEDOUTSIDE): 
    //println("Action:RELEASED OUTSIDE");
    break;
    case(ControlP5.ACTION_BROADCAST): 
    //println("Action:BROADCAST");
    break;
  }
  //}
}
