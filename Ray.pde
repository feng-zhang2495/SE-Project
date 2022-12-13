class Ray {
  // FIELDS
  MagnifyingGlass glass;

  // CONSTRUCTOR
  Ray(MagnifyingGlass mg) {
    this.glass = mg;
  }

  // METHODS
  // Draws the rays extending from the sun to the magnifying glass to the focal point
  void drawMe() {
    int numLines = 12;
    float deltaX = 140/12;
    float increment = 0;
    float x  = 400-(numLines/2)*deltaX+5;
    int color1 = int(random(235,245));
    int color2 = int(random(240,250));
    int color3 = int(random(0,120));
    
    // Draws the flickering sun
    noStroke();
    fill(color1,color2,color3);
    ellipse(400,80,140,140);
    
    fill(255,0,0);
    strokeWeight(material.beamIntensity + 1);
    stroke(255,0,0);
    
    
    // Draws lines from the sun to the magnifying glass to the focal point of the mirror
    for(int i = 0; i < numLines; i++){
      line(x, 80, this.glass.focalX - this.glass.radius * 2000 + increment, this.glass.y);
      line(this.glass.focalX - this.glass.radius * 2000 + increment, this.glass.y, this.glass.focalX,this.glass.focalY);
      x += deltaX;
      increment += deltaX;
    }
    
    // Draws a very small circle at the focal point
    color(255, 100, 100);
    noStroke();
    circle(this.glass.focalX,this.glass.focalY,5);
  }
}
