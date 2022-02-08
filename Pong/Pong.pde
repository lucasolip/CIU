import processing.sound.*;

Ball ball;
Paddle player1, player2;
int scorePlayer1, scorePlayer2;
PFont font;
boolean[] keys = new boolean[4];
SoundFile bounceSound1, bounceSound2, bounceSound3, hitSound, fanfareSound, pauseSound;
PImage wsKeysSprite, arrowKeysSprite;
String fontPath = "media/FFFFORWA.TTF";
int gameRunning = 0;
long lastHit = 0;
long handicapTime = 1000;

void setup() {
  size(720, 512);
  
  wsKeysSprite = loadImage("media/ws.png");
  arrowKeysSprite = loadImage("media/arrows.png");
  bounceSound1 = new SoundFile(this, "media/bounce1.wav");
  bounceSound2 = new SoundFile(this, "media/bounce2.wav");
  bounceSound3 = new SoundFile(this, "media/bounce3.wav");
  hitSound = new SoundFile(this, "media/hit.wav");
  pauseSound = new SoundFile(this, "media/pause.wav");
  fanfareSound = new SoundFile(this, "media/fanfare.wav");
  
  noLoop();
  begin();
}

void begin() {
  scorePlayer1 = 0;
  scorePlayer2 = 0;
  
  ball = new Ball(20, 6);
  player1 = new Paddle(10, 50, width - 50, 5);
  player2 = new Paddle(10, 50, 50, 5);
  
  textAlign(CENTER, CENTER);
  textFont(createFont(fontPath, 64));
  
  background(0);
  ball.display();
  ball.display();
  player1.display();
  player2.display();
  image(wsKeysSprite, width/5 - wsKeysSprite.width/2, 3*height/4);
  image(arrowKeysSprite, 4*width/5 - arrowKeysSprite.width, 3*height/4);
  noStroke();
  textFont(createFont(fontPath, 24));
  text("Lucas Olivares Pérez", width/2, 32);
  text("Pulsa espacio para comenzar\ny pausar", width/2, 2*height/3);
  textFont(createFont(fontPath, 64));
  text(scorePlayer1, width/4, height/4);
  text(scorePlayer2, 3*width/4, height/4);
}

void draw() {
  if (gameRunning == 1) {
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
      bounceSound1.play();
    }
    if (ball.collidesWithPlayer(player2)) {
      bounceSound2.play();
    }
    ball.update();
    
    // Game Rendering
    ball.display();
    player1.display();
    player2.display();
    
    checkEndgame();
  }
}

void checkEndgame() {
  if (scorePlayer1 > 9) {
    endgame("GANA", "PIERDE");
  }
  if (scorePlayer2 > 9) {
    endgame("PIERDE", "GANA");
  }
}

void endgame(String text1, String text2) {
  gameRunning = 0;
  fanfareSound.play();
  background(0);
  drawMidLine(16);
  noStroke();
  image(wsKeysSprite, width/5 - wsKeysSprite.width/2, 3*height/4);
  image(arrowKeysSprite, 4*width/5 - arrowKeysSprite.width, 3*height/4);
  textFont(createFont(fontPath, 24));
  text("Pulsa espacio para comenzar\ny pausar", width/2, 2*height/3);
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
  if (key == ' ') {
    if (gameRunning == 0) {
      begin();
      gameRunning = 1;
      loop();
    } else if (gameRunning == 2) {
      gameRunning = 1;
      loop();
    } else {
      text("PAUSA", width/2, 2*height/3);
      pauseSound.play();
      gameRunning = 2;
      noLoop();
    }
  }
  if (keyCode == ESC) {
    text("Cerrando...", width/2, 3*height/4);
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
