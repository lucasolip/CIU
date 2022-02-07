class Paddle {
  PVector position;
  int w, h;
  float speed;
  
  Paddle(int w, int h, int x, float speed) {
    position = new PVector(x, height/2);
    this.speed = speed;
    this.w = w;
    this.h = h;
  }
  
  void update(int direction) {
    position.y += speed*direction;
    edges();
  }
  
  void display() {
    rect(position.x, position.y, w, h);
  }
  
  void edges() {
    if (position.y < 0) {
      position.y = 0;
    } else if (position.y > height - h) {
      position.y = height - h;
    }
  }
}
