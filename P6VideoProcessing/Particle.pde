class Particle {
  PVector pos;
  PVector inipos;
  color inicolor;
  PVector vel;
  PVector acc;
  float maxSpeed = random(5, 15);
  float maxForce = random(0.5, 1.5);

  float r, d;

  Particle(float x, float y, float d) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    inipos = pos.copy();
    this.d = d;
    r = d/2;
  }

  void behaviours(PVector mouse) {
    PVector flee = flee(mouse);
    PVector arrive = arrive();
    flee.mult(5);
    arrive.mult(1);
    applyForce(flee);
    applyForce(arrive);
  }

  void applyForce(PVector f) {
    PVector force = f.copy();
    acc.add(force);
  }

  PVector flee(PVector mouse) {
    PVector desired = PVector.sub(pos, mouse);
    float d = desired.mag();
    if (d < 50) {
      desired.setMag(maxSpeed);
      return PVector.sub(desired, vel).limit(maxForce);
    } else {
      return new PVector(0, 0);
    }
  }

  PVector arrive() {
    PVector desired = PVector.sub(inipos, pos);
    float d = desired.mag();
    float speed = maxSpeed;
    if (d < 100) {
      speed = map(d, 0, 100, 0, maxSpeed);
    }
    desired.setMag(speed);
    return PVector.sub(desired, vel).limit(maxForce);
  }

  void update() {
    int index = floor(inipos.x) + floor(inipos.y) * cam.width;
    inicolor = color(cam.pixels[index]);
    pos.add(vel);
    vel.add(acc);    
    acc.mult(0);
  }

  void show() {
    fill(inicolor);
    ellipse(pos.x, pos.y, d, d);
  }
  
  void scatter() {
    pos.x = random(width);
    pos.y = random(height);
  }
}
