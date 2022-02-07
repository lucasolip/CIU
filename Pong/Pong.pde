Ball ball;
Paddle player1, player2;

void setup() {
  size(640, 480);
  noStroke();
  ball = new Ball(width/2, height/2, 20, 5);
  player1 = new Paddle(10, 50, width - 50, 5);
  player2 = new Paddle(10, 50, 50, 5);
}

void draw() {
  background(0);
  if (ball.collidesWithPlayer(player1) || ball.collidesWithPlayer(player2)) {
    ball.velocity.x *= -1;
  }
  ball.update();
  ball.display();
  player1.display();
  player2.display();
  if (keyPressed) {
    playerControl();
  }
}

void playerControl() {
  if (keyCode == UP) {
    player1.update(-1);
  } else if (keyCode == DOWN) {
    player1.update(1);
  }
  if (key == 'w') {
    player2.update(-1);
  } else if (key == 's') {
    player2.update(1);
  }
}

void keyPressed() {
  
}
