import processing.video.*;

Capture cam;
int mode = 0;
ArrayList<Particle> particles;
float particleSize = 10;
PVector mouse;
boolean help = true;

void setup() {
  size(640, 480);
  textFont(createFont("Segoe UI", 128));
  
  try {
    initializeParticleStyle();
    cam = new Capture(this, width, height, "pipeline:autovideosrc");
    cam.start();
    image(cam, 0, 0);
  } 
  catch (IllegalStateException e) {
    textAlign(CENTER, CENTER);
    textSize(48);
    background(0);
    stroke(255);
    text("Cámara no disponible", width/2, height/2);
  }
}

void draw() {
  if (null != cam && cam.available()) {
    background(255);
    cam.read();
    if (mode == 0) gridStyle(5, .1f, 2f, cam);
    if (mode == 1) circleStyle(width/2, height/2, 4, 4, .1, 3, cam);
    if (mode == 2) particleStyle();
    if (help) {
      fill(0,250);
      stroke(255);
      strokeWeight(2);
      rect(10, 20, 265, (mode < 2) ? 60 : 90);
      fill(255);
      textSize(18);
      if (mode < 2) text("Haz click para cambiar de modo\nH: Ocultar ayuda", 15, 40);
      else text("Haz click para cambiar de modo\nH: Ocultar ayuda\nPrueba a pulsar espacio", 15, 40);
    }
  }
}

void gridStyle(int lineStep, float minStroke, float maxStroke, PImage img) {
  img.loadPixels();
  background(0);
  stroke(255, 255);
  for (int i = 0; i < img.height; i += lineStep) {
    for (int j = 0; j < img.width; j++) {
      int index = j + i * img.width;
      strokeWeight(map(brightness(img.pixels[index]), 0, 255, minStroke, maxStroke));
      point(j, i);
    }
  }
  for (int i = 0; i < img.width; i += lineStep) {
    for (int j = 0; j < img.height; j++) {
      int index = i + j * img.width;
      strokeWeight(map(brightness(img.pixels[index]), 0, 255, minStroke, maxStroke));
      point(i, j);
    }
  }
}

void circleStyle(int centerX, int centerY, int circleStep, int initialRadius, float minStroke, float maxStroke, PImage img) {
  img.loadPixels();
  background(0);
  stroke(255, 150);
  for (int radius = initialRadius; radius < img.width; radius += circleStep) {
    float angleOffset = 1f/radius;
    for (float angle = 0; angle < TWO_PI; angle += angleOffset) {
      int x = floor(cos(angle)*radius) + centerX;
      int y = floor(sin(angle)*radius) + centerY;
      if (x < 0 || x >= img.width || y < 0 || y >= img.height) continue;
      int index = x + y * img.width;
      strokeWeight(map(brightness(img.pixels[index]), 0, 255, minStroke, maxStroke));
      point(x, y);
    }
  }
}

void particleStyle() {
  noStroke();
  mouse.x = mouseX;
  mouse.y = mouseY;

  cam.loadPixels();
  for (Particle particle : particles) {
    particle.behaviours(mouse);
    particle.update();
    particle.show();
  }
}

void initializeParticleStyle() {
  mouse = new PVector(mouseX, mouseY);
  particles = new ArrayList<Particle>();
  for (float i = particleSize; i < width; i += particleSize) {
    for (float j = particleSize; j < height; j += particleSize) {
      particles.add(new Particle(i, j, particleSize));
    }
  }
}

void mousePressed() {
  mode = (mode + 1) % 3;
}

void keyPressed() {
  if (mode == 2 && key == ' ') {
    for (Particle particle : particles) {
      particle.scatter();
    }
  }
  if (key == 'h' || key == 'H') {
    help = !help;
  }
}
