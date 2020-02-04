import java.util.Set;
import java.util.TreeMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;
int glo_x = 0;
int glo_y = 0;

void proc() {
  bg.loadPixels();
  post.beginDraw();
//  post.background(0);

  //for (int x = 0; x < bg.width; x += W) {
  //for (int y = 0; y < bg.height; y += H) {
  TreeMap<Float, Map> mapsOrdered = new TreeMap<Float, Map>();

  for (int mapIndex : maps.keySet()) {
    Map map = maps.get(mapIndex);

    map.pg.beginDraw();
    map.pg.loadPixels();
    float error = 0;
    float count = 0;
    for (int ix = 0; ix < W; ix += 1) {
      int xx = glo_x + ix;
      if (xx > bg.width-1) continue;
      for (int iy = 0; iy < H; iy += 1) {
        int yy = glo_y + iy;
        if (yy > bg.height-1) continue;

        int idx = yy * bg.width + xx;
        int midx = iy * W + ix;

        color mc = map.pg.pixels[midx];
        color ic = bg.pixels[idx];

        int mcr = (mc >> 16) & 0xff;
        int icr = (ic >> 16) & 0xff;

        int mcg = (mc >> 8) & 0xff;
        int icg = (ic >> 8) & 0xff;

        int mcb = (mc) & 0xff;
        int icb = (ic) & 0xff;

        float e = abs(mcr - icr) / 255.0;
        e += abs(mcg - icg) / 255.0;
        e += abs(mcb - icb) / 255.0;
        error += ( e / 3.0); 
        count += 1;
      }
    }
    map.pg.endDraw();
    float fError = pow(error / count, 2);
    mapsOrdered.put(fError, map);
  }
  Set<Entry<Float, Map>> set = mapsOrdered.entrySet();
  Map m = null;
  for (Entry<Float, Map> entry : set) {
    m = entry.getValue();
    break;
  }
  //Map m = 
  if (m!=null) {
    indexMap[glo_x/W][glo_y/H] = m.i;
    post.image(m.pg, glo_x, glo_y);
  }
  // }
  // }
  glo_x += W;
  if (glo_x > bg.width-1) {
    glo_x = 0;
    glo_y += H;
    if (glo_y > bg.height-1) {
      glo_x = 0;
      glo_y = 0;
    }
  }

  post.endDraw();
}
