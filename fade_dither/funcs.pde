void drawText(PGraphics canvas, String txt, float startX, float startY) {
  float w = canvas.width / txt.length();


  float x = startX;
  for (int c = 0; c < txt.length(); c += 1) {
    String l = str(txt.charAt(c));

    Letter A = getLetter(l);

    A.draw3d(canvas, x, startY, TWO_PI * (currentFrame / TOTAL_FRAMES), 5);
    x += w;
  }
}
