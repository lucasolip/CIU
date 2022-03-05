class Camera {
  PVector eye, target;
  PVector alternateViewEye, alternateViewTarget;
  
  boolean cameraControl = false;
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
      
      difference.x = mouseX - pmouseX;
      difference.y = mouseY - pmouseY;
      
      targetAngle.x = -difference.x * mouseSensitivity.x;
      targetAngle.y = difference.y * mouseSensitivity.y;
      xAngle = lerp(xAngle, targetAngle.x, dampening.x);
      yAngle = lerp(yAngle, targetAngle.y, dampening.y);
      angle.x += xAngle;
      angle.y += yAngle;
      
      target = vectorTranslate(target, PVector.mult(eye,-1));
      
      target = yRotate(target, angle.x);
      
      target = xRotate(target, yAngle);
      target = yRotate(target, xAngle);
      
      target = yRotate(target, -angle.x);
      
      target = vectorTranslate(target, eye);
      println(angle);
    }
  }
  
  void display() {
    beginCamera();
    camera(eye.x, eye.y, eye.z, target.x, target.y, target.z, 0, 1, 0);
    /*translate(eye.x, eye.y, eye.z);
    rotateX(yAngle);
    rotateY(xAngle);
    translate(-eye.x, -eye.y, -eye.z);*/
    endCamera();
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
  
  PVector xRotate(PVector point, float angle) {
    PVector result = new PVector();
    result.x = point.x;
    result.y = cos(angle)*point.y - sin(angle)*point.z;
    result.z = sin(angle)*point.y + cos(angle)*point.z;
    return result;
  }
  
  PVector yRotate(PVector point, float angle) {
    PVector result = new PVector();
    result.x = cos(angle)*point.x + sin(angle)*point.z;
    result.y = point.y;
    result.z = -sin(angle)*point.x + cos(angle)*point.z;
    return result;
  }
  
  PVector vectorTranslate(PVector origin, PVector destination) {
    return PVector.add(origin, destination);
  }
}
