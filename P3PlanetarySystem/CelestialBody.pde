abstract class CelestialBody {
  PImage texture;
  PShape model;
  PVector position;
  float angle = 0;
  float rotationAngle = 0;
  float rotationSpeed = random(-.05, .05);
  float radius;
  
  CelestialBody(float radius) {
    this.radius = radius;
  }
}
