import processing.sound.*;

Ball ball;
Paddle player1, player2;
int scorePlayer1, scorePlayer2;
PFont font;
boolean[] keys = new boolean[4];
SoundFile bounceSound1, bounceSound2, bounceSound3, hitSound, fanfareSound;
String fontPath = "media/FFFFORWA.TTF";
boolean gameRunning = false;

void setup() {
  size(640, 480);
  
  bounceSound1 = new SoundFile(this, "media/bounce1.wav");
  bounceSound2 = new SoundFile(this, "media/bounce2.wav");
  bounceSound3 = new SoundFile(this, "media/bounce3.wav");
  hitSound = new SoundFile(this, "media/hit.wav");
  fanfareSound = new SoundFile(this, "media/fanfare.wav");
  
  noLoop();
  begin();
}

void begin() {
  scorePlayer1 = 0;
  scorePlayer2 = 0;
  
  ball = new Ball(20, 10);
  player1 = new Paddle(10, 50, width - 50, 5);
  player2 = new Paddle(10, 50, 50, 5);
  
  textAlign(CENTER, CENTER);
  textFont(createFont(fontPath, 64));
}

void draw() {
  background(0);
  
  // User Interface
  drawMidLine(16);
  noStroke();
  text(scorePlayer1, width/4, height/4);
  text(scorePlayer2, 3*width/4, height/4);
  
  if (keyPressed) {
    playerControl();
  }
  
  // Physics
  if (ball.collidesWithPlayer(player1)) {
    ball.velocity.x *= -1;
    bounceSound1.play();
  }
  if (ball.collidesWithPlayer(player2)) {
    ball.velocity.x *= -1;
    bounceSound2.play();
  }
  ball.update();
  
  // Game Rendering
  ball.display();
  player1.display();
  player2.display();
  
  checkEndgame();
}

void checkEndgame() {
  if (scorePlayer1 > 2) {
    endgame("GANA", "PIERDE");
  }
  if (scorePlayer2 > 2) {
    endgame("PIERDE", "GANA");
  }
}

void endgame(String text1, String text2) {
  gameRunning = false;
  fanfareSound.play();
  background(0);
  drawMidLine(16);
  noStroke();
  textFont(createFont(fontPath, 52));
  text(text1, width/4, height/4);
  text(text2, 3*width/4, height/4);
  player1.display();
  player2.display();
  noLoop();
}

void playerControl() {
  if (keys[0]) {
    player1.update(-1);
  } else if (keys[1]) {
    player1.update(1);
  }
  if (keys[2]) {
    player2.update(-1);
  } else if (keys[3]) {
    player2.update(1);
  }
}

void drawMidLine(float lineSize) {
  stroke(255);
  strokeWeight(3);
  for (int y = 0; y < height; y += 2*lineSize) {
    line(width/2, y, width/2, y + lineSize);
  }
}

void keyPressed() {
  if (keyCode == UP) {
    keys[0] = true;
  }
  if (keyCode == DOWN) {
    keys[1] = true;
  }
  if (key == 'w') {
    keys[2] = true;
  }
  if (key == 's') {
    keys[3] = true;
  }
  if (!gameRunning && key == ' ') {
    gameRunning = true;
    begin();
    loop();
  }
}

void keyReleased() {
  if (keyCode == UP) {
    keys[0] = false;
  }
  if (keyCode == DOWN) {
    keys[1] = false;
  }
  if (key == 'w') {
    keys[2] = false;
  }
  if (key == 's') {
    keys[3] = false;
  }
}
