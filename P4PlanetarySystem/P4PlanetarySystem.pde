/* 
    Lucas Olivares Pérez 
    Creando Interfaces de Usuario - 2022
*/

import processing.sound.*;

PImage background;
PImage[] planetTextures;
String[] planetNames = {"Sedna", "Ávalon", "Vanth", "Megera", "Dómino", "Ésoso", "Gruye"};
SoundFile music;

Camera camera;
ArrayList<Planet> planets;
ArrayList<Planet> satellites;
Star star;
PShape skysphere;

boolean help = true;
final int numPlanets = 5;

void setup()
{
  size(1024, 720, P3D);
  
  //textAlign(CENTER, CENTER);
  background = loadImage("media/outerspace.jpg");
  planetTextures = new PImage[] {
    loadImage("media/sedna.png"), 
    loadImage("media/earth-like.jpg"),
    loadImage("media/vanth.png"),
    loadImage("media/gasgiant2.png"), 
    loadImage("media/gasgiant.png"), 
    loadImage("media/planet.png"),
    loadImage("media/crateroso.png")};
  music = new SoundFile(this, "media/bubblaine underwater.wav");
  //music.loop();
  
  noStroke();
  planets = new ArrayList<Planet>();
  star = new Star(100);
  
  skysphere = createShape(SPHERE, 20000);
  skysphere.setTexture(background);
  camera = new Camera();
  
  generateSystem();
}

void draw()
{
  perspective(radians(45), float(width)/float(height), 10, 50000);
  camera.update();
  camera.display();
  
  pushMatrix();
  translate(camera.eye.x, camera.eye.y, camera.eye.z);
  shape(skysphere);
  popMatrix();

  star.display();
  star.update();
  
  for (Planet planet : planets) {
    //planet.displayName();
  }
  
  pointLight(255,255,255,0,0,0);
  
  for (Planet planet : planets) {
    planet.update();
    planet.display();
  }
  
  
  hint(DISABLE_DEPTH_TEST);
  noLights();
  camera(width*0.5, height*0.5, (height*0.5) / tan(PI/6), width*0.5, height*0.5, 0, 0, 1, 0);
  fill(255);
  if (help) text("R: Regenerar sistema\nH: Mostrar/Ocultar ayuda", 150, 125);
  hint(ENABLE_DEPTH_TEST);
}

void generateSystem() {
  noStroke();
  
  planets.clear();
  for (int i = 0; i < numPlanets; i++) {
    float distance = (i+1)*random((i+1)*150, (i+1)*200);
    planets.add(new Planet(distance, distance*random(.04,.08), star, planetTextures[i], planetNames[i]));
  }
  for (int i = 0; i < 2; i++) {
    Planet parent = planets.get(floor(random(1, numPlanets)));
    planets.add(new Planet(parent.radius + random(40, 90), parent.radius*random(.1, .3), random(0, PI), parent, planetTextures[i+numPlanets], planetNames[i+numPlanets]));
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    generateSystem();
  }
  if (key == 'h' || key == 'H') {
    help = !help;
  }
  if (key == 'q' || key == 'Q') {
    camera.swapView();
  }
}
