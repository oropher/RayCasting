int noRayos = 36;
int noMuros = 6;
Muro[] muros;
Ray[] rays;
float divisiones = TWO_PI / noRayos;
float distMax = 20;

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
