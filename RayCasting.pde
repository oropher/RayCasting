
int noRayos = 36;
int noMuros = 6;
Muro[] muros;
Ray[] rays;
float divisiones = TWO_PI / noRayos;
float distMax = 200;

void setup() {
  size(400, 400);
  muros = new Muro[noMuros];
  for(int i = 0; i < noMuros; i++) {
    muros[i] = new Muro(random(400), random(400), random(400), random(400));
  }
  //muro = new Muro(300, 100, 300, 300);
  rays = new Ray[noRayos];
  for(int i = 0; i < noRayos; i++){
    float angle = TWO_PI / noRayos * i;
    rays[i] = new Ray(100, 200, new PVector(1*cos(angle), 1*sin(angle)));
    //rays[i] = new Ray(1*cos(angle), 1*sin(angle));
  }
  //ray = new Ray(100, 200);
}



void draw(){
  background(57);
  //ray.lookAt(mouseX, mouseY);
  for(int rayIndex = 0; rayIndex<noRayos; rayIndex++) {
    Ray ray = rays[rayIndex];
    ray.updatePos(mouseX, mouseY);
    ray.show();
    PVector punto = null;
    float minDist = 9999999999f;
    for(int i = 0; i<noMuros; i++) {
      muros[i].show();
      PVector puntoAux = ray.cast(muros[i]);
      if(puntoAux == null){
        continue;
      }
      float distAux = PVector.dist(puntoAux, ray.pos);
      if(distAux < minDist && distAux <= distMax){
        punto = puntoAux;
        minDist = distAux;
      }
    }
    if(punto != null) {
      stroke(255, 100);
      //circle(punto.x, punto.y, 10);
      line(ray.pos.x, ray.pos.y, punto.x, punto.y);
    }
  }
}



class Muro {

  PVector a;
  PVector b;

  public Muro(float x1, float y1, float x2, float y2) {
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
  }

  public void show(){
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }

}

class Ray {

  PVector pos;
  PVector dir;
  color c = color(255);

  public Ray(float x, float y, PVector dir){
    this.pos = new PVector(x, y);
    //this.dir = new PVector(1, 0);
    this.dir = dir;
  }

  public void show(){
    stroke(c);
    push();
    translate(this.pos.x, this.pos.y);
    //line(0, 0, dir.x * 10, dir.y * 10);
    pop();
  }

  public void updatePos(float x, float y) {
    this.pos = new PVector(x, y);
  }

  public void lookAt(float x, float y){
    this.dir.x = x - this.pos.x;
    this.dir.y = y - this.pos.y;
    this.dir.normalize();
  }
  
  public PVector cast(Muro muro){
    float x1 = muro.a.x;
    float y1 = muro.a.y;
    float x2 = muro.b.x;
    float y2 = muro.b.y;

    float x3 = this.pos.x;
    float y3 = this.pos.y;
    float x4 = this.pos.x + this.dir.x;
    float y4 = this.pos.y + this.dir.y;

    float den = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
    if(den != 0) {
      float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/den;
      float u = -1*((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/den;

      if(0.0f < t && t < 1.0f && 0.0f < u) {
        PVector punto = new PVector(x1 + t * (x2-x1), y1 + t * (y2-y1));
        return punto;
      } else {
        c = color(255);
        return null;
      }
    } else {
      return null;
    }
  }
}























