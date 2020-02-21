PImage base = null;
PGraphics output = null;
PGraphics[] frames = null;
int frameIndex = -1;
String[] effects = {"BTN_FX_PIXELATE", "BTN_FX_REPLACE", "BTN_FX_DITHER", "BTN_FX_CORRUPT", "BTN_FX_MOVE_R", "BTN_FX_MOVE_G", "BTN_FX_MOVE_B", "BTN_FX_MOVE_ALL", "BTN_FX_MESS", "BTN_FX_VHS", "BTN_FX_EDGE"};
String[] effects_labels = {"PIXELATE", "REPLACE", "DITHER", "CORRUPT", "MOVE_R", "MOVE_G", "MOVE_B", "MOVE_ALL", "MESS", "VHS", "EDGE"};

import controlP5.*;
final String IMAGE_PATH = "S:\\PHOTOS";

long dt_last = getTime();
long dt_now = getTime();
long dt = 0;

float fps_counter = 0;
final float FPS = 18;
final float MS_PER_FRAME = 1000.0 / FPS;


ArrayList<Button> buttons = new ArrayList<Button>();
ScrollableList listEffectChain;
ControlP5 cntrl;
Group grpEffects;
Group grpControls;
enum COL {
  R, G, B, ALL, A;
}
CallbackListener cbl;
Textarea info;


//---------------------------- CONTROLS VARIABLES

float sld_pixelate_min = 4;
float sld_pixelate_max = 16;

void setup() {
  size(800, 600);

  //set up dither matrix

  dither_matrix_factors = new float[4][4];

  float n = 1.0 / 16.0;
  for (int x = 0; x < 4; x += 1) {
    for (int y = 0; y < 4; y += 1) {

      dither_matrix_factors[x][y] = dither_matrix[x][y] * n;
    }
  }

  //set up controls

  cntrl = new ControlP5(this);
  grpEffects = cntrl.addGroup("effects").setPosition(0, 18).setLabel("EFFECTS").setWidth(width).setHeight(15).setBackgroundColor(color(51)).setBackgroundHeight(20);
  grpControls = cntrl.addGroup("controls").setPosition(120, 68).setLabel("CONTROLS").setWidth(width-120).setHeight(15).setBackgroundColor(color(51, 64)).setBackgroundHeight(100);

  cntrl.addButton("BTN_C_LOAD_IMAGE").setLabel("load image").setPosition(0, 0).setGroup(grpControls);
  cntrl.addButton("BTN_C_PROCESS").setLabel("process").setPosition(80, 0).setGroup(grpControls);
  cntrl.addButton("BTN_C_RESET").setLabel("reset").setPosition(0, 30).setGroup(grpControls);


  listEffectChain = cntrl.addScrollableList("effect_chain").setPosition(0, 50).setSize(100, height-50).setBarHeight(18).setItemHeight(18);
  //listEffectChain.setLock(true);
  info = cntrl.addTextarea("Hello").setPosition(0, height/2);

  cntrl.addSlider("sld_pixelate_min").setGroup(grpControls).setPosition(0, 60).setWidth(grpControls.getWidth()/3).setLabel("pix min").setMin(1).setMax(32).setDecimalPrecision(0).setDefaultValue(4);
  cntrl.getController("sld_pixelate_min").getValueLabel().align(ControlP5.RIGHT, ControlP5.RIGHT);
  cntrl.addSlider("sld_pixelate_max").setGroup(grpControls).setPosition(0, 70).setWidth(grpControls.getWidth()/3).setLabel("pix max").setMin(1).setMax(32).setDecimalPrecision(0).setDefaultValue(16);
  cntrl.getController("sld_pixelate_max").getValueLabel().align(ControlP5.RIGHT, ControlP5.RIGHT);

  grpEffects.disableCollapse();
  grpControls.disableCollapse();
  //cbl = new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    switch(theEvent.getAction()) {
  //      case(ControlP5.PRESSED):

  //      case(ControlP5.ACTION_ENTER):
  //      //info.n = 1;
  //      info.setText(theEvent.getAction() + "\n" + theEvent.getController().getInfo());
  //      cursor(HAND);
  //      break;
  //      case(ControlP5.ACTION_LEAVE):
  //      case(ControlP5.ACTION_RELEASEDOUTSIDE):

  //      cursor(ARROW);
  //      break;
  //    }
  //  }
  //};
  // cntrl.addCallback(cbl);
  float xstep = width / float(effects.length + 1);
  float x = xstep/2;
  for (int i = 0; i < effects.length; i += 1) {
    String name = effects[i];
    String label = effects_labels[i];
    Button b = cntrl.addButton(name).setLabel(label).setGroup(grpEffects).setPosition(x, 0);
    buttons.add(b);

    x += xstep;
  }
}


void draw() {

  dt_now = getTime();
  dt = dt_now - dt_last;
  dt_last = dt_now;

  fps_counter += dt;
  if (fps_counter >= MS_PER_FRAME) {
    fps_counter %= MS_PER_FRAME;
    if (frames != null) {
      frameIndex += 1;
      if (frameIndex > frames.length-1) {
        frameIndex = 0;
      }

      output = frames[frameIndex];
    }
  }


  background(0);

  if (output != null) {
    image(output, 0, 0, width, height);
    fill(255);
    text("output", 10, height-20);
  } else if (base != null) {
    image(base, 0, 0, width, height);
    text("base", 10, height-20);
  }
}
