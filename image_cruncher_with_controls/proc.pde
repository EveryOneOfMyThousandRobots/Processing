import java.util.List;
void createOutputImage() {



  if (base != null) {

    long t = System.nanoTime();
    String ns = Long.toHexString(t);
    noiseSeed(ns.hashCode());
    NoiseManager nm = new NoiseManager();

    frames = new PGraphics[25];
    for (int f = 0; f < 25; f += 1) {
      output = createGraphics(base.width, base.height);
      output.beginDraw();
      output.copy(base, 0, 0, base.width, base.height, 0, 0, output.width, output.height);

      ArrayList<HashMap<String, Object>> list = new ArrayList(listEffectChain.getItems());
      //for (HashMap map : list) {
      //  for (Object k : map.keySet()) {
      //    Object v = map.get(k);
      //    print("\t[" + k.toString() + " " + k.getClass() + "] [" + v.toString() + " " + v.getClass() + "]");
      //    print("\n\tnext item");
      //  }
      //  print("\nnext");
      //}


      for (int i = 0; i < list.size(); i += 1) {
        String item = (String)list.get(i).get("name");
        String name = item + "_" + i;
        switch (item) {
        case "PIXELATE":
          pixelate(nm, output, name, f);
          break;
        case "REPLACE":
          color c = getMostCommonColour(g, 16);
          replaceColour(output, 16, c, color(255, 0, 0), color(255, 255, 0));      
          break;
        case "DITHER":
          dither(nm, output, name, f);
          break;
        case "CORRUPT":
          corruptDims(nm, output, name, f);
          break;
        case"MOVE_R":
          move(nm, output, COL.R, name, f);
          break;
        case "MOVE_G":
          move(nm, output, COL.G, name, f);
          break;
        case "MOVE_B":
          move(nm, output, COL.B, name, f);
          break;
        case "MOVE_ALL":
          move(nm, output, COL.ALL, name, f);
          break;
        case "MESS":
          Mess(nm, output, name, f);
          break;        
        case "VHS":
          VHS(name, output, f);
          break;
        case "EDGE":
          edgeDetect(nm, output, name, f);
        };
      }
      output.endDraw();
      frames[f] = output;
    }
  }
}
