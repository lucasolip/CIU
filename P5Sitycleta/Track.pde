class Track {
  Date startTime;
  Date endTime;
  PVector startLocation;
  PVector endLocation;
  float angle = 0;
  
  Track(Date startTime, Date endTime, PVector startLocation, PVector endLocation) {
    this.startTime = startTime;
    this.endTime = endTime;
    this.startLocation = startLocation.copy();
    this.endLocation = endLocation.copy();
    
    this.startLocation.x = map(this.startLocation.x, minlat, maxlat, 0, texture.width);
    this.startLocation.y = map(this.startLocation.y, minlon, maxlon, 0, texture.height);
    this.endLocation.x = map(this.endLocation.x, minlat, maxlat, 0, texture.width);
    this.endLocation.y = map(this.endLocation.y, minlon, maxlon, 0, texture.height);
  }
  
  void display() {
    map.pushMatrix();
    map.translate(texture.width/2, texture.height/2);
    map.rotate(-HALF_PI);
    map.translate(-texture.width/2 - 50, -texture.height/2 - 25);
    map.scale(1.15, 1);
    map.line(startLocation.x, startLocation.y, endLocation.x, endLocation.y);
    map.popMatrix();
  }
  
  boolean running(Date currentDate) {
    long current = currentDate.getTime();
    long start = startTime.getTime();
    long end = endTime.getTime();
    return current >= start && current <= end;
  }
}
