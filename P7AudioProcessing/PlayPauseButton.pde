class PlayPauseButton extends Button {

  PImage playIcon;
  PImage pauseIcon;

  PlayPauseButton(float x, float y, float w, float h, PImage playIcon, PImage pauseIcon) {
    super(x, y, w, h, playIcon);
    this.playIcon = playIcon;
    this.pauseIcon = pauseIcon;
    this.pauseIcon.resize(floor(w), floor(h));
  }

  public void action() {
    if (null != player) {
      if (player.isPlaying()) {
        player.pause();
        icon = playIcon;
      } else {
        player.loop();
        icon = pauseIcon;
      }
    }
  }

  public void setPlaying() {
    icon = pauseIcon;
  }
}
