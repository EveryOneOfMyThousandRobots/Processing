class Fluid {

  int size;
  float dt;
  float diff;
  float visc;

  float[] s;
  float[] density;

  float[] Vx;
  float[] Vy;
  float[] Vx0;
  float[] Vy0;

  Fluid(float dt, float diff, float visc) {
    this.size = N;
    this.dt = dt;
    this.diff = diff;
    this.visc = visc;

    this.s = new float[N*N]; 
    this.density = new float[N*N];

    this.Vx = new float[N*N];
    this.Vy = new float[N*N];


    this.Vx0 = new float[N*N];
    this.Vy0 = new float[N*N];
  }

  void draw(PGraphics cnv) {

    cnv.beginDraw();
    cnv.loadPixels();
    for (int x = 0; x < N; x += 1) {
      for (int y = 0; y <N;y += 1) {
        float g = 255 * (abs(Vx[IX(x,y)]) + abs(Vx[IX(x,y)]));
        float r = density[IX(x,y)];
        color c = color(r,g,0);
        cnv.pixels[IX(x,y)] = c;
      }
    }
    cnv.updatePixels();
    cnv.endDraw();
  }

  void addDye(int x, int y, float amt) {
    density[IX(x, y)] += amt;
  }
  
  void update() {
    

    diffuse(1, Vx0, Vx, visc, dt);
    diffuse(2, Vy0, Vy, visc, dt);
    
    project(Vx0, Vy0, Vx, Vy);
    //void advect(int b, float[] d, float[] d0, float[] velocX, float[] velocY, float dt)
    advect(1,Vx, Vx0, Vx0,Vy0,dt);
    advect(2,Vy, Vy0, Vx0,Vy0,dt);
    
    project(Vx, Vy, Vx0, Vy0);
    
    diffuse(0,s,density,diff,dt);
    advect(0,density,s,Vx,Vy,dt);
    
  }
  
  

  void addVel(int x, int y, float amountX, float amountY)
  {
    int index = IX(x, y);
    this.Vx[index] += amountX;
    this.Vy[index] += amountY;
    
  }
}

int IX(float x, float y) {
  x = constrain(x,0,N-1);
  y = constrain(y, 0,N-1);
  int xx = floor(x);
  int yy = floor(y);

  return yy * N + xx;
}

void diffuse (int b, float[] x, float[] x0, float diff, float dt)
{
    float a = dt * diff * (N - 2) * (N - 2);
    lin_solve(b, x, x0, a, 1 + 6 * a);
}
