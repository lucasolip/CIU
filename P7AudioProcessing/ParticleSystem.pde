class ParticleSystem {
  PVector pos;
  PVector vel;
  ArrayList<Particle> particles;
  ArrayList<Particle> toBeRemoved;
  
  public ParticleSystem(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    particles = new ArrayList<Particle>();
    toBeRemoved = new ArrayList<Particle>();
  }
  
  public void update(float rate) {
    
    if (rate != -2f) {
      int n = floor(map(rate, 0, 1, 0, 11));
      for (int i = 0; i < n; i++) {
        PVector speed = new PVector(random(-1, 1), random(-1, 1));
        speed.setMag(map(rate, 0, 1, 1, 10));
        particles.add(new Particle(pos.copy(), speed));
      }
    }
    
    for (Particle p : particles) {
      p.update();
      edges(p);
      p.display(2000);
    }
    for (Particle p : toBeRemoved) {
      particles.remove(p);
    }
  }
  
  public void edges(Particle p) {
    if (p.pos.y < 0 || p.pos.x < 0 || p.pos.x > width || p.pos.y > songControl.height) {
      toBeRemoved.add(p);
    }
  }
}
