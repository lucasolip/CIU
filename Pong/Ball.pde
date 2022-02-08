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
    velocity.y /= random(5, 10);
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
    if (position.x < radius) {
      velocity.x *= -1;
      position.x = radius;
      if (System.currentTimeMillis() - lastHit > handicapTime) {
        scorePlayer2++;
        lastHit = System.currentTimeMillis();
        hitSound.play();
      } else {
        bounceSound3.play();
      }
    }
    if (position.x > width - radius) {
      velocity.x *= -1;
      position.x = width - radius;
      if (System.currentTimeMillis() - lastHit > handicapTime) {
        scorePlayer1++;
        lastHit = System.currentTimeMillis();
        hitSound.play();
      } else {
        bounceSound3.play();
      }
    }
    if (position.y < radius) {
      velocity.y *= -1;
      position.y = radius;
      bounceSound3.play();
    }
    if (position.y > height - radius) {
      velocity.y *= -1;
      position.y = height - radius;
      bounceSound3.play();
    }
  }

  boolean collidesWithPlayer(Paddle player) {
    boolean collision = (position.x + velocity.x + radius > player.position.x &&
      position.y + velocity.y + radius > player.position.y &&
      position.x + velocity.x - radius < player.position.x + player.w &&
      position.y + velocity.y - radius < player.position.y + player.h);
    if (collides(position.x + velocity.x, position.y, player)) {
      velocity.x *= -1;
      velocity.y = random(-1, 1);
      velocity.setMag(speed);
      if (position.x + radius < player.position.x + player.w/2) {
        position.x = player.position.x - radius;
      } 
      if (position.x - radius > player.position.x + player.w/2) {
        position.x = player.position.x + player.w + radius;
      }
    }
    if (collides(position.x, position.y + velocity.y, player)) {
      velocity.y *= -1;
      if (position.y + radius < player.position.y + player.h/2) {
        position.y = player.position.y - radius;
      } 
      if (position.y - radius > player.position.y + player.h/2) {
        position.y = player.position.y + player.h + radius;
      }
    }
    return collision;
  }

  boolean collides(float x, float y, Paddle player) {
    return (x + radius > player.position.x &&
      y + radius > player.position.y &&
      x - radius < player.position.x + player.w &&
      y - radius < player.position.y + player.h);
  }
}
