class MinMax {
  float min_proj_box, max_proj_box, min_dot_box, max_dot_box;
  
  String toString() {
    return "mx (" + min_proj_box + "," + max_proj_box + ")";
  }
}


MinMax getMinMax(ArrayList<PVector> pnts, PVector axis) {

  
  
  MinMax mx = new MinMax();

  mx.min_proj_box = PVector.dot(pnts.get(0), axis);
  mx.min_dot_box = 0;

  mx.max_proj_box = PVector.dot(pnts.get(0), axis);
  mx.max_dot_box = 0;

  for (int j = 1; j < pnts.size(); j += 1) {
    float currentProj = pnts.get(j).dot(axis);

    if (currentProj < mx.min_proj_box) {
      mx.min_proj_box = currentProj;
      mx.min_dot_box = j;
    }

    if (currentProj > mx.max_proj_box) {
      mx.max_proj_box = currentProj;
      mx.max_dot_box = j;
    }
  }


  return mx;
}
