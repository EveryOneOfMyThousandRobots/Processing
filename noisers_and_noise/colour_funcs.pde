int getColour(int colour, COL_MODE mode) {
  switch (mode) {
  case COL_ALL:
    return colour;
  case COL_RED:
    return colour & 0x00ff0000;

  case COL_GREEN:
    return colour & 0x0000ff00;

  case COL_BLUE:
    return colour & 0x000000ff;
  case COL_ALPHA:
    return colour & 0xff000000;
  }



  return color(0);
}

int overwriteChannel(int A, int B, COL_MODE mode) {
  switch (mode) {
  case COL_ALL:
    return B;
  case COL_RED:
    return (A & 0xff00ffff) + getColour(B, mode);

  case COL_GREEN:
    return (A & 0xffff00ff) + getColour(B, mode);

  case COL_BLUE:
    return (A & 0xffffff00) + getColour(B, mode);
  case COL_ALPHA:
    return (A & 0x00ffffff) + getColour(B, mode);
  }

  return color(0);
}
