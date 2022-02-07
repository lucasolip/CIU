class Ball {
  PVector position, velocity;
  float diameter, radius, speed;
  
  Ball(float diameter, float speed) {
    this.speed = speed;
    this.diameter = diameter;
    radius = diameter/2;
    initialize();
  }
  
  void initialize() {
    position = new PVector(width/2, height/2);
    velocity = new PVector(random(-5, 5), random(-5, 5));
    velocity.y /= random(5,10);
    velocity.setMag(speed);
  }
  
  void update() {
    position.add(velocity);
  }
  
  void display() {
    ellipse(position.x, position.y, diameter, diameter);
    edges();
  }
  
  void edges() {
    boolean flag = false;
    if (position.x < radius) {
      velocity.x *= -1;
      position.x = radius;
      scorePlayer2++;
      hitSound.play();
    }
    if (position.x > width - radius) {
      velocity.x *= -1;
      position.x = width - radius;
      scorePlayer1++;
      hitSound.play();
    }
    if (position.y < radius) {
      velocity.y *= -1;
      position.y = radius;
      flag = true;
    }
    if (position.y > height - radius) {
      velocity.y *= -1;
      position.y = height - radius;
      flag = true;
    }
    if (flag) {
      bounceSound3.play();
    }
  }
  
  boolean collidesWithPlayer(Paddle player) {
    return (position.x + radius > player.position.x &&
            position.y + radius > player.position.y &&
            position.x - radius < player.position.x + player.w &&
            position.y - radius < player.position.y + player.h);
  }
}
