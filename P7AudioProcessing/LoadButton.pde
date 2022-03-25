class LoadButton extends Button {
  
  LoadButton(float x, float y, float w, float h, PImage icon) {
    super(x, y, w, h, icon);
  }
  
  public void action() {
    selectInput("Select a file to process:", "fileSelected", dataFile("*.mp3"));
  }
}
