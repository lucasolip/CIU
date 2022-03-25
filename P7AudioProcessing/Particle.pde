class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  float time;
  
  public Particle(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    acc = new PVector(0, 0);
    r = 10;
    time = millis();
  }
  
  public void update() {
    vel.add(acc);
    pos.add(vel);
    
    acc.mult(0);
  }
  
  public void applyForce(PVector f) {
    acc.add(f.copy());
  }
  
  public void display(float end) {
    float col = map(millis()-time, 0, end, 255, 0);
    songControl.fill(255, col);
    songControl.noStroke();
    songControl.ellipse(pos.x, pos.y, r, r);
  }
}
