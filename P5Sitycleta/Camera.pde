class Camera {
  PVector eye, target;
  PVector angle;
  PVector targetAngle;
  float mouseSensitivity = 0.01;
  float moveSensitivity = 0.1;
  float dampening = 0.2;
  PVector difference, lerpAngle;
  float maxZoom = 25;
  
  Camera() {
    eye = new PVector(terrainSize/2, terrainSize/2, 150);
    target = new PVector(terrainSize/2, terrainSize/2, 0);
    angle = new PVector();
    targetAngle = new PVector();
    difference = new PVector();
    lerpAngle = new PVector();
  }
  
  void display() {
    if (mousePressed) {
      if (mouseButton == LEFT) {
        difference.x = pmouseX - mouseX;
        difference.y = pmouseY - mouseY;
      } else {
        difference.mult(0);
      }
      if (mouseButton == CENTER) {
        target.x += cos(angle.y)*(pmouseX - mouseX) * moveSensitivity + sin(angle.y)*(pmouseY - mouseY) * moveSensitivity;
        eye.x += cos(angle.y)*(pmouseX - mouseX) * moveSensitivity + sin(angle.y)*(pmouseY - mouseY) * moveSensitivity;
        target.y += sin(angle.y)*(pmouseX - mouseX) * moveSensitivity + cos(angle.y)*(pmouseY - mouseY) * moveSensitivity;
        eye.y += sin(angle.y)*(pmouseX - mouseX) * moveSensitivity + cos(angle.y)*(pmouseY - mouseY) * moveSensitivity;
      }
    } else {
      difference.mult(0);
    }
    
    targetAngle.x = difference.x * mouseSensitivity;
    targetAngle.y = difference.y * mouseSensitivity;
    lerpAngle.x = lerp(lerpAngle.x, targetAngle.x, dampening);
    lerpAngle.y = lerp(lerpAngle.y, targetAngle.y, dampening);
    angle.y += lerpAngle.x;
    angle.x += lerpAngle.y;
    
    if (angle.x < 0) {
      angle.x = 0;
    } else if (angle.x > PI*0.4) {
      angle.x = PI*0.4;
    }
    
    camera(eye.x, eye.y, eye.z, target.x, target.y, target.z, 0, 1, 0);
    translate(target.x, target.y, 0);
    rotateX(angle.x);
    rotateZ(angle.y);
    translate(-target.x, -target.y, 0);
  }
  
  void setZoom(float zoom) {
    eye.z += zoom;
    if (eye.z < maxZoom) eye.z = maxZoom;
  }
}
