PVector A = new PVector();
PVector B = new PVector();
PVector C = new PVector();
void findNext() {



  checkEdges();
  numChecks = 0;
  neighboursFound = 0;
  neighboursNeighboursfound = 0;
  boolean done = false;
  for (int i = tris.size()-1; i >= 0; i -= 1) {
    Tri tri = tris.get(i);

    done = false;
    if (tri.allEdgesFull) continue;

    for (Edge e : tri.edges) {
      if (!e.full) {

        A.set(e.x1, e.y1);
        B.set(e.x2, e.y2);
        C.set(0, 0);


        //find point on neighbour
        for (int j = tri.countNeighbours()-1; j >= 0; j -= 1) {
          Tri nbr = tri.getNeighbour(j);


          for (PVector p : nbr.points) {
            C.set(p);
            if (valid(A, B, C)) {
              addNew(A, B, C, tri, nbr);
              neighboursFound += 1;
              done = true;
            }
          }

          if (!done) {
            for (int k = nbr.countNeighbours()-1; k >= 0; k -= 1) {
              Tri nbr2 = nbr.getNeighbour(k);

              for (PVector p : nbr2.points) {
                C.set(p);
                if (valid(A, B, C)) {
                  addNew(A, B, C, tri, nbr2);
                  neighboursNeighboursfound += 1;
                  done =true;
                }
              }
            }
          }
        }

        if (!done) {
          for (int k = 0; k < 5; k += 1) {
            Tri r = tris.get(floor(random(tris.size())));
            for (PVector p : r.points) {
              C.set(p);
              if (valid(A, B, C)) {
                addNew(A, B, C, tri, r);
                //neighboursNeighboursfound += 1;
                done =true;
              }
            }
          }
        }

        if (!done) {
          //find any shape
          for (int tries = 0; tries < 2; tries += 1) {
            numChecks += 1;
            C.set(randVector(A.x, A.y));
            if (valid(A, B, C)) {
              addNew(A, B, C, tri);
            }
          }
        }
      }
    }


    if (tri.countNeighbours() == 0) {
    } else {
    }
  }
}
