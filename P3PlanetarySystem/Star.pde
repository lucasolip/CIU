class Star extends CelestialBody {
  
  Star(float radius) {
    super(radius);
    noStroke();
    
    texture = loadImage("media/sun.jpg");
    model = createShape(SPHERE, radius);
    model.setTexture(texture);
    position = new PVector(0,0,0);
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateY(rotationAngle);
    shape(model);
    popMatrix();
  }
  
  void update() {
    rotationAngle += rotationSpeed;
  }
}
