class Ray {
  // FIELDS
  float beamIntensity;

  // CONSTRUCTOR
  Ray(float b) {
    this.beamIntensity = b;
  }

  // METHODS
  void drawMe() {
    int numLine = 12;
    float deltaX = 140/12;
    float x  = 90;
    int color1 = int(random(220,245));
    int color2 = int(random(235,250));
    int color3 = int(random(0,120));
    noStroke();
    fill(color1,color2,color3);
    ellipse(150,80,140,140);
		
    for( int i = 0; i < numLine; i++){
      fill(255,0,0);
      strokeWeight(4);
      stroke(255,0,0);
      line(x,80,x,300);
      x+=deltaX;
    }
  }
}