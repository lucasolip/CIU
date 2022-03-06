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

    rotateY(-angle);
    rotateX(-secondaryAngle);
    rotateY(-reference.angle);
    float distance = PVector.dist(camera.eye, PVector.add(MatrixOperations.xRotate(MatrixOperations.yRotate(position, angle), secondaryAngle), MatrixOperations.yRotate(reference.position, reference.angle)));
    float size = 0.02*(distance/QUARTER_PI);
    translate(0, -2*radius);
    if (camera.cameraControl) {
      rotateZ(camera.angle.y*-sin(camera.angle.x));
      rotateX(camera.angle.y*cos(camera.angle.x));
      rotateY(camera.angle.x);
    } else {
      rotateY(PI);
    }
    fill(-1);
    textSize(size);
    textAlign(CENTER, CENTER);
    text(name, 0, 0);
    popMatrix();
  }
}
