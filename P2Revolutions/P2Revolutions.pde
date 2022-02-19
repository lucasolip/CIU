ArrayList<PVector> vertices;
PShape surface;
boolean surfaceCreated = false;
final int numRings = 28;
final float angleStep = TWO_PI/numRings;
float shapeAngle = 0;
PVector previousVertex;
boolean light, rotation, wireframe, fill, help;

void setup() {
  size(640, 480, P3D);
  vertices = new ArrayList<PVector>();
  light = rotation = false;
  wireframe = fill = help = true;
  noFill();
  stroke(255);
  strokeWeight(3);
  textSize(18);
}

void draw() {
  background(50);
  if (surfaceCreated) {
    if (help) text("R: Rotar\nL: Iluminar\nW: Mallado\nF: Relleno\nEspacio: Reiniciar\nH: Ayuda", 15, 30);
    if (light) directionalLight(255, 255, 255, 1, 1, -0.1);
    translate(width/2, height/2, -300);
    rotateX(shapeAngle);
    translate(0, -height/2, 0);
    shape(surface);
    if (rotation) shapeAngle += 0.05;
  } else {
    if (help) text("Click: Añadir vértices\nClick y arrastrar: Dibujar\nEspacio: Generar superficie\nH: Ayuda", 15, 30);
    mouseControl();
    translate(width/2, 0, 0);
  }
}

void mouseControl() {
  if (mousePressed) {
    PVector mouse = new PVector(mouseX - width/2, mouseY);
    if (mouse.x > 0 && (null == previousVertex || PVector.dist(mouse, previousVertex) > 10)) {
      if (vertices.size() < 1) {
        vertices.add(new PVector(0, mouse.y));
      }
      previousVertex = new PVector(mouse.x, mouse.y);
      vertices.add(new PVector(mouse.x, mouse.y));
    } else if (mouse.x < 0 && (null == previousVertex || PVector.dist(mouse, previousVertex) > 10)) {
      if (vertices.size() < 1) {
        vertices.add(new PVector(0, mouse.y));
      }
      previousVertex = new PVector(-mouse.x, mouse.y);
      vertices.add(new PVector(-mouse.x, mouse.y));
    }
  }
}

void showUI() {
  line(0, 0, 0, height);
  for (int i = 0; i < vertices.size(); i++) {
    if (i < vertices.size() - 1) {
      line(vertices.get(i).x, vertices.get(i).y, vertices.get(i+1).x, vertices.get(i+1).y);
    }
  }
  if (null != previousVertex && vertices.size() > 0) {
    line(vertices.get(vertices.size() - 1).x, vertices.get(vertices.size() - 1).y, mouseX - width/2, mouseY);
  }
}

void keyPressed() {
  if (key == ' ') {
    if (vertices.size() > 0 && !surfaceCreated) generateShape();
    else vertices.clear();
    surfaceCreated = !surfaceCreated;
  } else if (key == 'r') {
    rotation = !rotation;
  } else if (key == 'l') {
    light = !light;
  } else if (key == 'f') {
    fill = !fill;
    generateShape();
  } else if (key == 'w') {
    wireframe = !wireframe;
    generateShape();
  } else if (key == 'h') {
    help = !help;
  }
}

void generateShape() {
  vertices.add(new PVector(0, vertices.get(vertices.size()-1).y));
  surface = createShape();
  surface.beginShape(TRIANGLES);
  if (!fill) surface.noFill();
  else surface.fill(255);
  if (!wireframe) surface.noStroke();
  else {
    surface.stroke(0);
    surface.strokeWeight(2);
  }
  float currentAngle, previousAngle;
  for (previousAngle = 0, currentAngle = angleStep; currentAngle < TWO_PI + angleStep; previousAngle = currentAngle, currentAngle += angleStep) {
    for (int i = 0; i < vertices.size(); i++) {
      setQuad(vertices.get(i), vertices.get((i + 1) % vertices.size()), previousAngle, currentAngle);
    }
  }
  surface.endShape();
}

void setQuad(PVector vertex, PVector nextVertex, float previousAngle, float currentAngle) {
  float prevX = vertex.x * cos(previousAngle) - vertex.z * sin(previousAngle);
  float prevZ = vertex.x * sin(previousAngle) + vertex.z * cos(previousAngle);
  float x = vertex.x * cos(currentAngle) - vertex.z * sin(currentAngle);
  float z = vertex.x * sin(currentAngle) + vertex.z * cos(currentAngle);
  float nextPrevX = nextVertex.x * cos(previousAngle) - nextVertex.z * sin(previousAngle);
  float nextPrevZ = nextVertex.x * sin(previousAngle) + nextVertex.z * cos(previousAngle);
  float nextX = nextVertex.x * cos(currentAngle) - nextVertex.z * sin(currentAngle);
  float nextZ = nextVertex.x * sin(currentAngle) + nextVertex.z * cos(currentAngle);
  surface.vertex(prevX, vertex.y, prevZ);
  surface.vertex(x, vertex.y, z);
  surface.vertex(nextPrevX, nextVertex.y, nextPrevZ);
  surface.vertex(x, vertex.y, z);
  surface.vertex(nextPrevX, nextVertex.y, nextPrevZ);
  surface.vertex(nextX, nextVertex.y, nextZ);
}
