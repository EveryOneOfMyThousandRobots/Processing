import java.util.List;
void createOutputImage() {

  if (base != null) {
    output = createGraphics(base.width, base.height);
    output.beginDraw();
    output.copy(base, 0, 0, base.width, base.height, 0, 0, output.width, output.height);

    ArrayList<HashMap<String,Object>> list = new ArrayList(listEffectChain.getItems());
    //for (HashMap map : list) {
    //  for (Object k : map.keySet()) {
    //    Object v = map.get(k);
    //    print("\t[" + k.toString() + " " + k.getClass() + "] [" + v.toString() + " " + v.getClass() + "]");
    //    print("\n\tnext item");
    //  }
    //  print("\nnext");
    //}
     
    NoiseManager nm = new NoiseManager();
    for (int i = 0; i < list.size(); i += 1) {
      String item = (String)list.get(i).get("name");
      String name = item + "_" + i;
      switch (item) {
      case "PIXELATE":
        pixelate(nm, output, name, 0);
        break;
      case "REPLACE":
        color c = getMostCommonColour(g, 16);
        replaceColour(output, 16, c, color(255, 0, 0), color(255, 255, 0));      
        break;
      case "DITHER":
        dither(nm, output, name, 0);
        break;
      case "CORRUPT":
        corruptDims(nm, output, name, 0);
        break;
      case"MOVE_R":
        move(nm, output, COL.R, name,0);
        break;
      case "MOVE_G":
        move(nm, output, COL.G, name,0);
        break;
      case "MOVE_B":
        move(nm, output, COL.B, name,0);
        break;
      case "MOVE_ALL":
        move(nm, output, COL.ALL, name,0);
      case "MESS":
        Mess(nm, output, name,0);
        break;        
      case "VHS":
        VHS(name, output, 0);
        break;
      };
    }
    
  }

  output.endDraw();
}
