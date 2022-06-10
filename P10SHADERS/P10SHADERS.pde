PImage moonAlbedo, moonNormal, grassAlbedo, noNormal;

PVector lightDir;
PShader dirtMaterial, moonMaterial, grassMaterial, distort;
PShape grassObj;
PVector one = new PVector(1, 1, 1);
PVector backgroundColor = new PVector(55f/255f, 86f/255f, 128f/255f);
float noiseScale, noiseAmplitude, lacunarity, persistence;
int octaves = 6;
boolean scaling = true;
boolean distorting = false;
boolean help = true;

float angle = 0;
float fogIntensity = 30;

void setup() {
  size(480, 720, P3D);

  ((PGraphics3D)g).textureWrap(Texture.REPEAT); 

  lightDir = new PVector(0, 0, -1);
  distort = loadShader("distort.glsl");
  moonMaterial = loadShader("StandardFrag.glsl", "StandardVert.glsl");
  grassMaterial = loadShader("UnlitFrag.glsl", "GrassVert.glsl");
  dirtMaterial = loadShader("StandardFrag.glsl", "StandardVert.glsl");
  moonAlbedo = loadImage("MoonAlbedo.jpg");
  grassAlbedo = loadImage("GrassAlbedo2.jpg");
  noNormal = loadImage("FlatNormal.jpg");
  grassObj = loadShape("grassBlades.obj");  
  setStandardMaterial(moonMaterial, .8f, 1, 0, backgroundColor, one, one, moonAlbedo, 1.0, moonAlbedo, 5);
  setUnlitMaterial(grassMaterial, grassAlbedo);
  setStandardMaterial(dirtMaterial, .1f, 1, 0, backgroundColor, one, one, loadImage("DirtColor2.jpg"), 100.0, loadImage("DirtHeight2.png"), 5);
  noiseScale = 9;
  noiseAmplitude = 90;
  persistence = 0.35;
  lacunarity = 2.25;
  imageMode(CENTER);
  textAlign(RIGHT);
  textSize(18);
}

void draw() {
  noStroke();
  drawScene();
  if (distorting) {
    setDistortion();
  }
  if (help) {
    drawUI();
  }
}

void drawUI() {
  hint(DISABLE_DEPTH_TEST);
  stroke(255);
  noLights();
  if (!distorting) text("D: Distorsionar imagen\nH: Mostrar/ocultar ayuda\nR: Reiniciar", width - 15, 50);
  else {
    text("D: No distorsionar imagen\nS: Cambiar modo de escalado\nH: Mostrar/ocultar ayuda\nR: Reiniciar", width - 15, 50);
    text("Escala: "+noiseScale+"\nAmplitud: "+noiseAmplitude+"\nLacunaridad: "+lacunarity+"\nPersistencia: "+persistence, width - 15, height - 125);
  }
  hint(ENABLE_DEPTH_TEST);
}

void drawScene() {
  background(backgroundColor.x*255, backgroundColor.y*255, backgroundColor.z*255);

  lightDir.x = map(mouseX, 0, width, 1, -1);
  lightDir.y = map(mouseY, 0, height, 1, -1);
  directionalLight(255, 255, 255, lightDir.x, lightDir.y, lightDir.z);

  grassMaterial.set("u_time", millis()*0.5f);
  grassMaterial.set("windScale", 0.001f);
  grassMaterial.set("windStrength", 50f);
  shader(grassMaterial);
  pushMatrix();
  translate(640/2, 480/2 + 350, 0);
  scale(50, 50, 50);
  rotateX(PI);
  shape(grassObj);
  popMatrix();

  shader(dirtMaterial);

  pushMatrix();
  rotateX(HALF_PI);
  translate(0, -480/2, -640/2);
  scale(50);
  translate(-640/2, -480/2, -5);
  quad(0, 0, 640, 0, 640, 480, 0, 480);
  popMatrix();

  shader(moonMaterial);

  pushMatrix();
  translate(0, 0, -750);
  rotateY(angle);
  sphere(250);
  popMatrix();

  angle += 0.002f;
}

void setDistortion() {
  if (scaling) {
    noiseScale = map(mouseX, 0, width, .1, 10);
    noiseAmplitude = map(mouseY, 0, height, .1, 100);
  } else {
    lacunarity = map(mouseX, 0, width, 0, 4);
    persistence = map(mouseY, 0, height, 0, 1.5);
  }

  distort.set("noiseScale", noiseScale);
  distort.set("noiseAmplitude", noiseAmplitude);
  distort.set("lacunarity", lacunarity);
  distort.set("persistence", persistence);
  distort.set("octaves", octaves);
  distort.set("u_time", millis()*0.001);
  filter(distort);
}

void setStandardMaterial(PShader material, float ambientIntensity, float diffuseIntensity, float specularIntensity, PVector ambientColor, PVector diffuseColor, PVector specularColor, PImage albedo, float scale, PImage bumpMap, float bumpScale) {
  material.set("ambientIntensity", ambientIntensity);
  material.set("diffuseIntensity", diffuseIntensity);
  material.set("specularIntensity", specularIntensity);
  material.set("ambientColor", ambientColor.x, ambientColor.y, ambientColor.z);
  material.set("diffuseColor", diffuseColor.x, diffuseColor.y, diffuseColor.z);
  material.set("specularColor", specularColor.x, specularColor.y, specularColor.z);
  material.set("texMap", albedo);
  material.set("scale", scale);
  material.set("bumpMap", bumpMap);
  material.set("bumpScale", bumpScale);
  material.set("fogIntensity", fogIntensity);
}

void setUnlitMaterial(PShader material, PImage albedo) {
  material.set("texMap", albedo);
  material.set("ambientColor", backgroundColor.x, backgroundColor.y, backgroundColor.z);
  material.set("fogIntensity", fogIntensity);
}

void keyPressed() {
  if (distorting && key == 's') scaling = !scaling;
  if (key == 'd') {
    distorting = !distorting;
    ((PGraphics3D)g).textureWrap((distorting)? Texture.CLAMP : Texture.REPEAT);
  }
  if (key == 'r') {
    scaling = true;
    distorting = false;
    noiseScale = 9;
    noiseAmplitude = 90;
    persistence = 0.35;
    lacunarity = 2.25;
  }
  if (key == 'h') help = !help;
}
