class Ray {
  // FIELDS
  MagnifyingGlass glass;

  // CONSTRUCTOR
  Ray(MagnifyingGlass mg) {
    this.glass = mg;
  }

  // METHODS
  void drawMe() {
    int numLines = 12;
    float deltaX = 140/12;
    float x  = 400-(numLines/2)*deltaX+5;
    int color1 = int(random(235,245));
    int color2 = int(random(240,250));
    int color3 = int(random(0,120));
    noStroke();
    fill(color1,color2,color3);
    ellipse(400,80,140,140);
    
    fill(255,0,0);
    strokeWeight(4);
    stroke(255,0,0);
    
    for(int i = 0; i < numLines; i++){
      line(x, 80, x, 300);
      line(x, 300, this.glass.focalX, this.glass.focalY);
      x += deltaX;
    }
    
    // Focal point
    color(255, 100, 100);
    noStroke();
    circle(this.glass.focalX,this.glass.focalY,5);
    //println(this.glass.focalX,this.glass.focalY);
  }
}
