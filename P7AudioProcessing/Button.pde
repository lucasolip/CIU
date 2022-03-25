abstract class Button {
  PImage icon;
  float w, h;
  PVector position;
  boolean clicked = false;
  
  Button(float x, float y, float w, float h, PImage icon) {
    position = new PVector(x, y);
    this.w = w;
    this.h = h;
    this.icon = icon;
    this.icon.resize(floor(w), floor(h));
  }
  
  public boolean checkCollision() {
    return (mouseX > position.x - w*0.5f && mouseX < position.x + w*0.5f && mouseY > position.y - h*0.5f && mouseY < position.y + h*0.5f);
  }
  
  public void onMouseClicked() {
    if (checkCollision()) {
      clicked = true;
    }
  }
  
  public void onMouseReleased() {
    if (clicked && checkCollision()) {
      action();
    }
    clicked = false;
  }
  
  public void display(PGraphics window) {
    if (clicked) window.tint(200);
    else window.tint(255);
    window.image(icon, position.x, position.y);
  }
  
  public abstract void action();
}
