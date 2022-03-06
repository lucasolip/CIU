class Camera {
  PVector eye, target;
  PVector alternateViewEye, alternateViewTarget;
  
  boolean cameraControl = false;
  boolean inverted = true;
  float speed = 25f;
  float xAngle = 0;
  float yAngle = 0;
  PVector targetAngle;
  PVector angle;
  PVector difference;
  PVector mouseSensitivity;
  PVector dampening;
  
  Camera() {
    eye = new PVector(0, -2500, -8000);
    target = new PVector();
    alternateViewEye = new PVector(0, -2500, 8000);
    alternateViewTarget = new PVector();
    difference = new PVector();
    mouseSensitivity = new PVector(.01, .01);
    dampening = new PVector(0.2, 0.2);
    targetAngle = new PVector();
    angle = new PVector();
  }
  
  void update() {
    if (cameraControl) {
      if (keyPressed && key == ' ') {
        PVector moveDirection = PVector.sub(target, eye);
        moveDirection.setMag(speed);
        eye.add(moveDirection);
        target.add(moveDirection);
      }
      
      if (mousePressed) {
        difference.x = pmouseX - mouseX;
        difference.y = pmouseY - mouseY;
        if (!inverted) difference.mult(-1);
      } else {
        difference.mult(0);
      }
      
      
      targetAngle.x = -difference.x * mouseSensitivity.x;
      targetAngle.y = difference.y * mouseSensitivity.y;
      xAngle = lerp(xAngle, targetAngle.x, dampening.x);
      yAngle = lerp(yAngle, targetAngle.y, dampening.y);
      angle.x += xAngle;
      angle.y += yAngle;
      
      target = MatrixOperations.vectorTranslate(target, PVector.mult(eye,-1));
      
      target = MatrixOperations.zRotate(target, yAngle*-sin(angle.x));
      target = MatrixOperations.xRotate(target, yAngle*cos(angle.x));
      
      target = MatrixOperations.yRotate(target, xAngle);
      
      target = MatrixOperations.vectorTranslate(target, eye);
    }
  }
  
  void display() {
    camera(eye.x, eye.y, eye.z, target.x, target.y, target.z, 0, 1, 0);
  }
  
  void showSpaceship() {
    pushMatrix();
    PVector movingEye = (cameraControl)? eye : alternateViewEye;
    PVector movingTarget = (cameraControl)? target : alternateViewTarget;
    PVector position = PVector.sub(movingTarget, movingEye);
    position.setMag(50);
    position.add(movingEye);
    translate(position.x, position.y, position.z);
    rotateZ(angle.y*-sin(angle.x));
    rotateX(angle.y*cos(angle.x));
    rotateY(angle.x + HALF_PI);
    shape(spaceship);
    popMatrix();
  }
  
  void swapView() {
    PVector tempEye, tempTarget;
    tempEye = eye;
    tempTarget = target;
    eye = alternateViewEye;
    target = alternateViewTarget;
    alternateViewEye = tempEye;
    alternateViewTarget = tempTarget;
    cameraControl = !cameraControl;
  }
  
  void reset() {
    eye = new PVector(0, -2500, 8000);
    target = new PVector();
    angle = new PVector();
  }
  
  
}
