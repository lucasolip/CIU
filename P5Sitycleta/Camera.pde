class Camera {
  PVector eye, target;
  float angle = 0;
  float targetAngle = 0;
  float mouseSensitivity = 0.01;
  float moveSensitivity = 0.1;
  float dampening = 0.2;
  float difference, lerpAngle;
  float maxZoom = 25;
  
  Camera() {
    eye = new PVector(terrainSize/2, terrainSize/2, 150);
    target = new PVector(terrainSize/2, terrainSize/2, 0);
    //MatrixOperations.vectorTranslate(eye, new PVector(0, 0, 0));
  }
  
  void display() {
    if (mousePressed) {
      if (mouseButton == LEFT) {
        difference = pmouseX - mouseX;
      } else {
        difference = 0;
      }
      if (mouseButton == CENTER) {
        target.x += (pmouseX - mouseX) * moveSensitivity;
        eye.x += (pmouseX - mouseX) * moveSensitivity;
        target.y += (pmouseY - mouseY) * moveSensitivity;
        eye.y += (pmouseY - mouseY) * moveSensitivity;
      }
    } else {
      difference = 0;
    }
    
    targetAngle = difference * mouseSensitivity;
    lerpAngle = lerp(lerpAngle, targetAngle, dampening);
    angle += lerpAngle;
    
    camera(eye.x, eye.y, eye.z, target.x, target.y, target.z, 0, 1, 0);
    translate(target.x, target.y, 0);
    rotateX(PI*0.15);
    rotateZ(angle);
    translate(-target.x, -target.y, 0);
  }
  
  void setZoom(float zoom) {
    eye.z += zoom;
    if (eye.z < maxZoom) eye.z = maxZoom;
  }
}
