class HandleController {
  PVector pos;
  boolean clicked = false;
  float diameter, radius;
  
  HandleController(float x, float y, float diameter) {
    pos = new PVector(x, y);
    this.diameter = diameter;
    radius = diameter*0.5;
  }
  
  void update() {
    if (clicked) {
      pos.x = mouseX;
      pos.y = mouseY - songControl.height;
      edges();
    }
  }
  
  void display() {
    if (clicked) songFrequencies.fill(0, 240);
    else songFrequencies.fill(0, 50);
    songFrequencies.ellipse(pos.x, pos.y, diameter, diameter);
  }
  
  void edges() {
    if (pos.x > songFrequencies.width - radius) {
      pos.x = songFrequencies.width - radius;
    }
    if (pos.x < radius) {
      pos.x = radius;
    }
    if (pos.y > songFrequencies.height - radius) {
      pos.y = songFrequencies.height - radius;
    }
    if (pos.y < radius) {
      pos.y = radius;
    }
  }
  
  PVector getValue() {
    return new PVector(pos.x/songFrequencies.width, pos.y/songFrequencies.height);
  }
  
  public boolean checkCollision() {
    return PVector.dist(pos, new PVector(mouseX, mouseY - songControl.height)) < radius;
  }
  
  public void onMouseClicked() {
    if (checkCollision()) {
      clicked = true;
    }
  }
  
  public void onMouseReleased() {
    clicked = false;
  }
}
