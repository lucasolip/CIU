class Ball {
  PVector position, velocity;
  float diameter, radius;
  
  Ball(int x, int y, float diameter, float speed) {
    position = new PVector(x, y);
    velocity = new PVector(random(5), random(5));
    velocity.setMag(speed);
    this.diameter = diameter;
    radius = diameter/2;
  }
  
  void update() {
    position.add(velocity);
  }
  
  void display() {
    ellipse(position.x, position.y, diameter, diameter);
    edges();
  }
  
  void edges() {
    if (position.x < radius) {
      velocity.x *= -1;
      position.x = radius;
    }
    if (position.x > width - radius) {
      velocity.x *= -1;
      position.x = width - radius;
    }
    if (position.y < radius) {
      velocity.y *= -1;
      position.y = radius;
    }
    if (position.y > height - radius) {
      velocity.y *= -1;
      position.y = height - radius;
    }
  }
  
  boolean collidesWithPlayer(Paddle player) {
    return (position.x + radius > player.position.x &&
            position.y + radius > player.position.y &&
            position.x - radius < player.position.x + player.w &&
            position.y - radius < player.position.y + player.h);
  }
}
