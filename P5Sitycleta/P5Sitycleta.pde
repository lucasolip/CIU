import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParsePosition;
import java.util.TimeZone;
import java.util.Locale;

PShape terrain;
PShape bike;
PImage texture, heightMap;
float terrainSize = 100;
float terrainHeight = 25;
XML mapData;
Table bikeData;
HashMap<String, PVector> locations;
ArrayList<Track> tracks;
float minlat, minlon, maxlat, maxlon;
PGraphics map;
PFont font;
Camera cam;

long lowerBound, upperBound;
Date currentTime;
long timeSpeed = 60000;
long fastTimeSpeed = 600000;
float timeHolding = 0;
SimpleDateFormat UIDateFormat, UIHourFormat, sdf;

float bikeAngle = 0;

void setup() {
  size(640, 480, P3D);
  
  font = createFont("Open Sans", 128);
  textFont(font);
  bike = loadShape("bicicleta.obj");
  
  cam = new Camera();
  
  sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm", new Locale("es"));
  UIDateFormat = new SimpleDateFormat("dd/MM/yyyy", new Locale("es"));
  UIHourFormat = new SimpleDateFormat("HH:mm", new Locale("es"));
  sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
  currentTime = sdf.parse("01/01/2021 07:00", new ParsePosition(0));
  lowerBound = sdf.parse("01/01/2021 00:00", new ParsePosition(0)).getTime();
  upperBound = sdf.parse("31/12/2021 23:59", new ParsePosition(0)).getTime();
  
  texture = loadImage("pmap.png");
  heightMap = loadImage("heightmap.png");
  map = createGraphics(texture.width, texture.height);
  map.beginDraw();
  map.image(texture,0,0);
  map.endDraw();
  
  initializeData();
  
  /*map.beginDraw();
  for (Track track : tracks) {
    track.display();
  }
  map.endDraw();*/

  noStroke();
  generateTerrain();
}

void draw() {
  cam.display();
  perspective(radians(45), float(width)/float(height), 0.01, 2000);
  background(50);
  ambientLight(155,155,155);
  directionalLight(255,255,255,-1,1,0);

  shape(terrain);
  for (String location : locations.keySet()) {
    pushMatrix();
    PVector station = locations.get(location).copy();
    station.x = map(station.x, minlat, maxlat, 0, terrainSize);
    station.y = map(station.y, minlon, maxlon, 0, terrainSize);
    station.z = terrainHeight*brightness(heightMap.pixels[floor(map(station.x, 0, terrainSize, 0, heightMap.width)) + floor(map(station.y, 0, terrainSize, 0, heightMap.height)) * heightMap.width])/255;
    translate(terrainSize/2, terrainSize/2, 0);
    rotateZ(-HALF_PI);
    translate(-terrainSize/2, -terrainSize/2, 0);
    translate(station.x, station.y, 5);
    pushMatrix();
    scale(0.7);
    rotateX(HALF_PI);
    rotateY(bikeAngle);
    shape(bike);
    popMatrix();
    popMatrix();
  }
  int currentTracks = 0;
  map.beginDraw();
  map.image(texture, 0, 0);
  map.stroke(255,0,0);
  map.strokeWeight(3);
  for (Track track : tracks) {
    if (track.running(currentTime)) {
      track.display();
      currentTracks++;
    }
  }
  map.endDraw();
  
  displayUI(currentTracks);
  timeControl();
  bikeAngle += 0.05;
}

void initializeData() {
  mapData = loadXML("map.xml");
  bikeData = loadTable("SITYCLETA-2021.csv", "header");
  locations = new HashMap<String, PVector>();
  tracks = new ArrayList<Track>();
  
  XML bounds = mapData.getChildren("bounds")[0];
  
  minlat = bounds.getFloat("minlat");
  minlon = bounds.getFloat("minlon");
  maxlat = bounds.getFloat("maxlat");
  maxlon = bounds.getFloat("maxlon");
  
  println(minlon, maxlon, minlat, maxlat);
  
  for (TableRow row : bikeData.rows()) {
    String location = row.getString("Rental place");
    if (location != null && !locations.containsKey(location)) {
      println(location);
      locations.put(location, new PVector());
    }
    location = row.getString("Return place");
    if (location != null && !locations.containsKey(location)) {
      println(location);
      locations.put(location, new PVector());
    }
  }
  for (XML node : mapData.getChildren("node")) {
    for (XML tag : node.getChildren("tag")) {
      for (String location : locations.keySet()) {
        if (locations.get(location).x != 0) continue;
        if (tag.getString("v").contains(location)) {
          locations.put(location, new PVector(node.getFloat("lat"), node.getFloat("lon")));
        }
      }
    }
  }
  for (Iterator<Entry<String, PVector>> iter = locations.entrySet().iterator(); iter.hasNext();) {
    Entry<String, PVector> entry = iter.next();
    if ((entry.getValue().x > -.1f && entry.getValue().x < .1f)) {
      iter.remove();
    }
  }
  for (TableRow row : bikeData.rows()) {
    String rentalLocation = row.getString("Rental place");
    String returnLocation = row.getString("Return place");
    String startTime = row.getString("Start");
    String endTime = row.getString("End");
    if (rentalLocation != null && returnLocation != null && locations.containsKey(rentalLocation) && locations.containsKey(returnLocation)) {
      tracks.add(new Track(sdf.parse(startTime, new ParsePosition(0)), sdf.parse(endTime, new ParsePosition(0)), locations.get(rentalLocation), locations.get(returnLocation)));
    }
  }
  
  println(tracks.size());
}

void displayUI(int currentTracks) {
  hint(DISABLE_DEPTH_TEST);
  noLights();
  camera(width*0.5, height*0.5, (height*0.5) / tan(PI/6), width*0.5, height*0.5, 0, 0, 1, 0);
  fill(255);
  textSize(18);
  textAlign(CENTER, CENTER);
  text(UIDateFormat.format(currentTime), width/2, 80);
  textSize(16);
  text("Trayectos en marcha: " + currentTracks, width - 190, height - 90);
  textSize(32);
  text(UIHourFormat.format(currentTime), width/2, 100);
  hint(ENABLE_DEPTH_TEST);
}

void timeControl() {
  if (keyPressed && keyCode == RIGHT) {
    currentTime = new Date(currentTime.getTime() + 86400000);
  } else if (keyPressed && keyCode == LEFT) {
    currentTime = new Date(currentTime.getTime() - 86400000);
  } else if (keyPressed && keyCode == UP) {
    currentTime = new Date(currentTime.getTime() + timeSpeed);
    timeHolding += 1/frameRate;
    if (timeHolding > 3) {
      timeSpeed = fastTimeSpeed;
    }
  } else if (keyPressed && keyCode == DOWN) {
    currentTime = new Date(currentTime.getTime() - timeSpeed);
    timeHolding += 1/frameRate;
    if (timeHolding > 3) {
      timeSpeed = fastTimeSpeed;
    }
  } else {
    timeHolding = 0;
    timeSpeed = 60000;
  }
  if (currentTime.getTime() < lowerBound) {
    currentTime = new Date(upperBound);
  } else if (currentTime.getTime() > upperBound) {
    currentTime = new Date(lowerBound);
  }
}

void generateTerrain() {
  terrain = createShape();
  terrain.setTexture(map);
  heightMap.loadPixels();
  for (int i = 0; i < terrainSize; i++) {
    terrain.beginShape(QUADS);
    terrain.textureMode(NORMAL);
    for (int j = 0; j < terrainSize; j++) {
      float vertexHeight = terrainHeight*brightness(heightMap.pixels[floor(map(i, 0, terrainSize, 0, heightMap.width)) + floor(map(j, 0, terrainSize, 0, heightMap.height)) * heightMap.width])/255;
      terrain.vertex(i, j, vertexHeight, i/terrainSize, j/terrainSize);
      if (i != terrainSize-1) {
        vertexHeight = terrainHeight*brightness(heightMap.pixels[floor(map(i + 1, 0, terrainSize, 0, heightMap.width)) + floor(map(j, 0, terrainSize, 0, heightMap.height)) * heightMap.width])/255;
        terrain.vertex(i + 1, j, vertexHeight, (i+1)/terrainSize, j/terrainSize);
      }
      if (i != terrainSize-1) {
        if (j < terrainSize-1) vertexHeight = terrainHeight*brightness(heightMap.pixels[floor(map(i + 1, 0, terrainSize, 0, heightMap.width)) + floor(map(j + 1, 0, terrainSize, 0, heightMap.height)) * heightMap.width])/255;
        terrain.vertex(i + 1, j+1, vertexHeight, (i+1)/terrainSize, (j+1)/terrainSize);
      } 
      if (j < terrainSize-1) vertexHeight = terrainHeight*brightness(heightMap.pixels[floor(map(i, 0, terrainSize, 0, heightMap.width)) + floor(map(j + 1, 0, terrainSize, 0, heightMap.height)) * heightMap.width])/255;
      terrain.vertex(i, j+1, vertexHeight, i/terrainSize, (j+1)/terrainSize);
      
    }
    terrain.endShape();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  cam.setZoom(10*e);
}
