void updateCells() {
  //  println("beginning update");
  for (int y = 0; y < cells[0].length; y += 1) {
    for (int x = 0; x < cells.length; x += 1) {
      // println("\tbeginning " + x + "\n");

      // print(" " + y);
      cells[x][y].update();
    }
  }

  //for (int x = 0; x < CA; x += 1) {
  //  for (int y = 0; y < CD; y += 1) {
  //    cells[x][y].pressure = cells[x][y].newPressure;
  //  }
  //}
}
