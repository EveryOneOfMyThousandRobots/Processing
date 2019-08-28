void drawOut() {
  //stroke(255);
  for (FPair f : output) {
    if (!f.valid) continue;
    stroke(f.c);
    point(f.px,f.py);
  }
  
  
  
}

void drawIn() {
  for (int i = 0; i < input.size(); i += 1) {
    
    FPair in = input.get(i);
    FPair out = output.get(i);
    
    if (!out.valid) continue;
    
    stroke(out.c);
    point(in.px, in.py);
    
  }
}
