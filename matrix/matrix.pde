String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvqxyz░▒▓▲►▼◄┌┐└┘├┤┴┬┼═║╒╓╔╖╕╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦◌○◊●☺☻☼♀♂♠♣♥♦♫♪☺☻☼♀♂♠♣♥♦♫♪ḆḡḨӘӀҒҷЅχβμλξ";
//String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvqxyz";//░▒▓▲►▼◄┌┐└┘├┤┴┬┼═║╒╓╔╖╕╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦◌○◊●☺☻☼♀♂♠♣♥♦♫♪☺☻☼♀♂♠♣♥♦♫♪ḆḡḨӘӀҒҷЅχβμλξ";
float textSize = 26;

PShader blur;
ArrayList<Stream> streams = new ArrayList<Stream>();





void setup() {
  size(800, 500, P2D);
  textFont(createFont("Lucida Sans Unicode Regular", textSize));
  
  blur = loadShader("blur.glsl");
  blur.init();
 // blur.set("yes",true);
  for (int i = 0x30a0; i < 0x30ff; i += 1) {
    alphabet += new String(Character.toChars(i));
  }
  println(alphabet);
  for (float x = 0; x < width; x += textSize) {
    streams.add(new Stream(x, 0));
  }
}

void draw() {
  background(0);
  filter(blur);
  for (Stream stream : streams) { 
    stream.update();
    stream.draw();
  }
  
}