class Planet extends CelestialBody {
  CelestialBody reference;
  float speed;
  float secondaryAngle;
  float distance;
  String name;
  
  Planet(float distance, float radius, CelestialBody reference, PImage texture, String name) {
    super(radius);
    this.reference = reference;
    this.distance = distance;
    position = new PVector(distance,0,0);
    this.radius = radius;
    speed = (1/distance)*random(5, 15);
    this.texture = texture;
    model = createShape(SPHERE, radius);
    model.setTexture(texture);
    this.name = name;
  }
  
  Planet(float distance, float radius, float secondaryAngle, CelestialBody reference, PImage texture, String name) {
    super(radius);
    this.reference = reference;
    position = new PVector(distance,0,0);
    this.radius = radius;
    speed = (1/distance)*random(3, 8);
    this.secondaryAngle = secondaryAngle;
    noStroke();
    this.texture = texture;
    model = createShape(SPHERE, radius);
    model.setTexture(texture);
    this.name = name;
  }
  
  void update() {
    angle += speed;
    rotationAngle += rotationSpeed;
  }
  
  void display() {
    stroke(255);
    noFill();
    pushMatrix();
    rotateY(reference.angle);
    translate(reference.position.x, reference.position.y, reference.position.z);
    
    rotateX(secondaryAngle);
    rotateY(angle);
    
    pushMatrix();
    translate(reference.position.x, reference.position.y, reference.position.z);
    rotateX(HALF_PI);
    circle(0,0,2*distance);
    popMatrix();
    
    translate(position.x, position.y, position.z);
    rotateY(rotationAngle);
    
    fill(255);
    shape(model);
    popMatrix();
  }
  
  void displayName() {
    stroke(255);
    pushMatrix();
    rotateY(reference.angle);
    translate(reference.position.x, reference.position.y, reference.position.z);
    rotateX(secondaryAngle);
    rotateY(angle);
    translate(position.x, position.y, position.z);
    float rotx = -atan2(camera.y, camera.z);
    float roty = atan2(camera.x, sqrt(camera.y*camera.y + camera.z*camera.z));
    float distance = PVector.dist(camera, position);
    rotateY(-reference.angle);
    rotateX(-secondaryAngle);
    rotateY(-angle);
    rotateX(rotx);
    rotateY(roty);
    fill(-1);
    textSize(0.02*distance);
    text(name, 0, -2*radius);
    popMatrix();
  }
}
