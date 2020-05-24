
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
    //stroke(c);
    //push();
    //translate(this.pos.x, this.pos.y);
    //line(0, 0, dir.x * 10, dir.y * 10);
    //pop();
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

