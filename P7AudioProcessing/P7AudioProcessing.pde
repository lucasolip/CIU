import ddf.minim.*; 
import ddf.minim.effects.*; 
import ddf.minim.analysis.*;

float passBand;
float bandWidth;
String soundfile;

Minim minim;
AudioPlayer player;
BandPass bandFilter;
FFT fft;
Button[] buttons;
PImage loadIcon;
PGraphics songControl, songFrequencies;
HandleController handle;
ParticleSystem ps;
PVector discPosition;
PImage discIcon;
float diameter = 50;
float angle = 0;
float maxSpeed = 0.1;
float angularSpeed = 0;

public void setup()
{
  //fullScreen();
  size(640, 640);

  songControl = createGraphics(width, height/2);
  songFrequencies = createGraphics(width, height - songControl.height);
  songControl.imageMode(CENTER);

  discIcon = loadImage("media/disc.png");

  minim = new Minim(this);
  buttons = new Button[] { 
    new LoadButton(songControl.width - 50, songControl.height - 50, 50, 50, loadImage("media/loadIcon.png")), // https://www.flaticon.com/free-icons/music
    new PlayPauseButton(songControl.width/2, songControl.height - 50, 75, 75, loadImage("media/play.png"), loadImage("media/pause.png"))// https://www.flaticon.com/free-icons/play, https://www.flaticon.com/free-icons/pause
  };
  handle = new HandleController(songFrequencies.width/2, songFrequencies.height/2, 40);
  discPosition = new PVector(songControl.width/2, songControl.height/3);
  ps = new ParticleSystem(discPosition.copy(), new PVector());

  textSize(20);
}

public void draw()
{
  songControl.beginDraw();
  songControl.background(25);
  for (Button button : buttons) {
    button.display(songControl);
  }

  diameter = (null != player)? lerp(diameter, map(abs(player.mix.level()), 0, 1, 50, 150), 0.2) : 50;
  ps.update((null == player || !player.isPlaying())? -2f : abs(player.mix.level()));
  songControl.pushMatrix();
  songControl.translate(discPosition.x, discPosition.y);
  if (null != player && player.isPlaying()) angularSpeed = lerp(angularSpeed, maxSpeed, 0.05);
  else angularSpeed = lerp(angularSpeed, 0, 0.05);
  angle += angularSpeed;
  songControl.rotate(angle);
  songControl.tint(255);
  songControl.fill(25);
  songControl.ellipse(0, 0, diameter, diameter);
  songControl.image(discIcon, 0, 0, diameter, diameter);
  songControl.popMatrix();
  songControl.endDraw();

  songFrequencies.beginDraw();
  songFrequencies.background(25);
  songFrequencies.stroke(240);
  songFrequencies.strokeWeight(2);
  songFrequencies.fill(240);
  if (null != fft) {
    fft.forward(player.mix);
    int portion = 3*fft.specSize()/4;
    for (int i = 0; i < portion; i++) {
      float xPos = map(i, 0, portion, 0, songFrequencies.width);
      songFrequencies.line(xPos, songFrequencies.height, xPos, songFrequencies.height - fft.getBand(i)*8);
    }
  }
  handle.update();
  handle.display();
  songFrequencies.endDraw();

  image(songControl, 0, 0);
  image(songFrequencies, 0, songControl.height);
}

public void mousePressed() {
  for (Button button : buttons) {
    button.onMouseClicked();
  }
  handle.onMouseClicked();
}

public void mouseReleased() {
  for (Button button : buttons) {
    button.onMouseReleased();
  }
  handle.onMouseReleased();
}

public void stop()
{
  player.close();
  minim.stop();

  super.stop();
}

void mouseDragged() {
  if (null != player) {
    PVector value = handle.getValue();
    bandFilter.setFreq(map(value.x, 0, 1, 100, 2000));
    bandFilter.setBandWidth(map(value.y, 0, 1, 0, 500));
  }
}

public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    soundfile = selection.getAbsolutePath();
    addSong();
  }
}

public void addSong() {
  if (null != player) player.close();
  player = minim.loadFile(soundfile);
  player.loop();
  bandFilter = new BandPass(440, 20, player.sampleRate());
  PVector value = handle.getValue();
  bandFilter.setFreq(map(value.x, 0, 1, 100, 2000));
  bandFilter.setBandWidth(map(value.y, 0, 1, 0, 500));
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.window(FFT.GAUSS);
  player.addEffect(bandFilter);
  ((PlayPauseButton)buttons[1]).setPlaying();
}
